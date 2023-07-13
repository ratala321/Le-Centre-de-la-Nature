class_name abstractInventaire extends Control

@export var inventaireParDefaut : Array

@onready var listeInventaire : ItemList = get_node("ItemList")
##reference au node etant proprietaire de l'inventaire
@onready var proprioInventaire = get_parent()
@onready var nomFichierSauvegarde : String = proprioInventaire.name
@onready var EMPLACEMENT_FICHIER_SAUVEGARDE : String = "user://" + nomFichierSauvegarde + ".txt"

##inventaire vers lequel les transferts sont procedes
var inventaireDestination

const nomNodeJoueur : String = "JoueurCanard"


func _ready():
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)


func _notification(notif):
	if notif == Node.NOTIFICATION_WM_CLOSE_REQUEST:
		var contenuInventaire : Array = getContenuInventaire()
		sauvegarderContenuInventaire(contenuInventaire)


##Permet de montrer l'interface	
func montrerInterface() -> void:
	show()
	Input.set_mouse_mode(3)
	get_tree().paused = true


##Permet de cacher l'interface
func cacherInterface() -> void:
	hide()
	Input.set_mouse_mode(2)
	get_tree().paused = false


##Permet de creer une reference a l'inventaire dans lequel les objets seront transferes
func ajouterReferenceInventaireDestination(referenceInventaireDestination) -> void:
	inventaireDestination = referenceInventaireDestination

##Permet d'effectuer le transfert d'un objet de l'inventaire courant
##vers l'inventaire de destination
func transfererObjetVersInventaireDestination(indexObjet : int) -> void:
	var listeInventaireDestination : ItemList = inventaireDestination.listeInventaire
	print("CLIC! dans " + self.name)
	print(listeInventaire.get_item_text(indexObjet))

	_copierObjetInventaireVersDestination(listeInventaireDestination, indexObjet)
	_copierMetadataObjetInventaireVersDestination(listeInventaireDestination, indexObjet)
	_retirerObjetDansInventaire(indexObjet)


func _retirerObjetDansInventaire(indexObjet : int) -> void:
	listeInventaire.remove_item(indexObjet)



func _copierObjetInventaireVersDestination(listeInventaireDestination, indexObjet) -> void:
	var nomObjet : String = listeInventaire.get_item_text(indexObjet)

	listeInventaireDestination.add_item(nomObjet)


##copie les meta donnees dans le dernier index de l'inventaire de destination
func _copierMetadataObjetInventaireVersDestination(listeInventaireDestination, indexObjet) -> void:
	var metadataObjet : Variant = listeInventaire.get_item_metadata(indexObjet)
	var indexObjetDestination : int = listeInventaireDestination.get_item_count() - 1

	listeInventaireDestination.set_item_metadata(indexObjetDestination, metadataObjet)
	


##Permet de charger le contenu sauvegarde de l'inventaire
##ou de creer son contenu dans le cas contraire
##NOTES : DOIT ETRE APPELE DANS LES CLASSES D'INVENTAIRE ENFANTS
func chargerContenuInventaire():
	#Ajouter chacun des objets dans la listeContenu dans le ItemList.
	print(EMPLACEMENT_FICHIER_SAUVEGARDE)
	print(FileAccess.file_exists(EMPLACEMENT_FICHIER_SAUVEGARDE))
	#retrait d'objets laisses par megarde
	listeInventaire.clear()

	if _fichierSauvegardeInventaireEstExistant():

		var donneesSauvegardees : Array = _lireFichierSauvegardeInventaire()

		#distribution des objets dans l'inventaire
		_distribuerObjetsSauvegardes(donneesSauvegardees)
	else:
		_chargerInventaireParDefaut()


func _fichierSauvegardeInventaireEstExistant() -> bool:
	return FileAccess.file_exists(EMPLACEMENT_FICHIER_SAUVEGARDE)


func _lireFichierSauvegardeInventaire() -> Array:
		var lecteurfichierDeSauvegarde = FileAccess.open(EMPLACEMENT_FICHIER_SAUVEGARDE, FileAccess.READ)
		var donneesSauvegardees : Array

		#lecture du fichier de sauvegarde
		while _lectureDuFichierEstIncomplete(lecteurfichierDeSauvegarde):
			donneesSauvegardees.push_back(lecteurfichierDeSauvegarde.get_var())
			donneesSauvegardees.push_back(lecteurfichierDeSauvegarde.get_var(true))

		lecteurfichierDeSauvegarde.close()

		return donneesSauvegardees


func _lectureDuFichierEstIncomplete(lecteurfichierDeSauvegarde) -> bool:
	return lecteurfichierDeSauvegarde.get_position() < lecteurfichierDeSauvegarde.get_length()


##Permet de distribuer les objets sauvegardes dans l'inventaire
func _distribuerObjetsSauvegardes(donneesSauvegardees) -> void:
	var nomObjet : String
	var metadataObjet : Variant

	var i : int = 0
	while _distributionEstIncomplete(i, donneesSauvegardees):
		nomObjet = donneesSauvegardees[i]
		metadataObjet = donneesSauvegardees[i+1]

		_ajouterObjetDansInventaire(nomObjet, metadataObjet)

		i += 2


func _distributionEstIncomplete(nombreObjetsDistribues : int, listeObjetsSauvegardes : Array) -> bool:
	return nombreObjetsDistribues < listeObjetsSauvegardes.size()


## L'inventaire par defaut contient le nom et les scenes des objets.
## Les objets doivent etre instancies avant d'etre mis dans l'inventaire du coffre.
func _chargerInventaireParDefaut() -> void:
	var nomObjet : String
	var sceneObjet : PackedScene
	var instanceObjet : Variant

	var i : int = 0
	while i < inventaireParDefaut.size():
		nomObjet = inventaireParDefaut[i]
		sceneObjet = inventaireParDefaut[i + 1]
		instanceObjet = sceneObjet.instantiate()
		_ajouterObjetDansInventaire(nomObjet, instanceObjet)
		i += 2


func _ajouterObjetDansInventaire(nomObjet : String, metadataObjet : Variant):
		listeInventaire.add_item(nomObjet)
		listeInventaire.set_item_metadata(-1, metadataObjet)


##Permet de sauvegarder le contenu d'un inventaire
func sauvegarderContenuInventaire(contenuInventaire : Array) -> void:
	var fichierDeSauvegarde = FileAccess.open(EMPLACEMENT_FICHIER_SAUVEGARDE, FileAccess.WRITE)
	var nomObjet : String
	var metadataObjet : Variant

	var i : int = 0
	while _sauvegardeContenuInventaireEstIncomplete(i, contenuInventaire):
		nomObjet = contenuInventaire[i]
		metadataObjet = contenuInventaire[i+1]

		fichierDeSauvegarde.store_var(nomObjet)
		fichierDeSauvegarde.store_var(metadataObjet, true)
		i += 2

	fichierDeSauvegarde.close()

func _sauvegardeContenuInventaireEstIncomplete(nombreObjetsSauvegardes : int, contenuInventaire : Array):
	return nombreObjetsSauvegardes < contenuInventaire.size()



func getContenuInventaire() -> Array:
	var nomObjet : String
	var metadataObjet : Variant
	var contenuInventaire : Array

	var i : int = 0
	while _parcoursContenuListeInventaireEstIncomplet(i):
		nomObjet = listeInventaire.get_item_text(i)
		metadataObjet = listeInventaire.get_item_metadata(i)

		contenuInventaire.push_back(nomObjet)
		contenuInventaire.push_back(metadataObjet)

		i += 1
	
	return contenuInventaire

func _parcoursContenuListeInventaireEstIncomplet(nombreObjetsParcourus : int) -> bool:
	return nombreObjetsParcourus < listeInventaire.item_count


#-------------------------------------------------------------------------------------------
#Methode abstraite selectionnerObjet() etant connecte au signal item_clicked de ItemList
#Permettant d'effectuer une ou des actions lorsqu'un objet dans l'inventaire est selectionne
#-------------------------------------------------------------------------------------------
