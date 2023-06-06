class_name abstractInventaire extends Control

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
		sauvegarderContenuInventaire()


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
func ajouterReferenceInventaireDestination(referenceInventaireDestination):
	inventaireDestination = referenceInventaireDestination
	pass

##Permet d'effectuer le transfert d'un objet de l'inventaire courant
##vers l'inventaire de destination
func transfererInventaire(indexObjet : int) -> void:
	var listeInventaireDestination : ItemList = inventaireDestination.get_node("ItemList")
	print("CLIC! dans " + self.name)
	print(listeInventaire.get_item_text(indexObjet))

	copierObjetInventaireDestination(listeInventaireDestination, indexObjet)
	copierMetadataObjetInventaireDestination(listeInventaireDestination, indexObjet)
	listeInventaire.remove_item(indexObjet)


##Permet de copier l'objet en cours de transfert vers l'inventaire de destination
func copierObjetInventaireDestination(listeInventaireDestination, indexObjet) -> void:
	var nomObjet : String = listeInventaire.get_item_text(indexObjet)

	listeInventaireDestination.add_item(nomObjet)


##Permet de copier le metadata de l'objet en cours de transfert vers l'inventaire de destination
func copierMetadataObjetInventaireDestination(listeInventaireDestination, indexObjet) -> void:
	var metadataObjet : Variant = listeInventaire.get_item_metadata(indexObjet)
	#index de l'objet dans l'inventaire de destination
	var indexObjetDestination : int = listeInventaireDestination.get_item_count() - 1

	listeInventaireDestination.set_item_metadata(indexObjetDestination, metadataObjet)
	


##Permet de charger le contenu sauvegarde de l'inventaire
##ou de creer son contenu dans le cas contraire
##NOTES : DOIT ETRE APPELE DANS LES CLASSES D'INVENTAIRE ENFANTS
func chargerContenuInventaire():
	#Ajouter chacun des objets dans la listeContenu dans le ItemList.
	print(EMPLACEMENT_FICHIER_SAUVEGARDE)
	print(FileAccess.file_exists(EMPLACEMENT_FICHIER_SAUVEGARDE))
	if FileAccess.file_exists(EMPLACEMENT_FICHIER_SAUVEGARDE):
		var fichierDeSauvegarde = FileAccess.open(EMPLACEMENT_FICHIER_SAUVEGARDE, FileAccess.READ)
		var donneesSauvegardees

		#vidage de l'inventaire par defaut
		listeInventaire.clear()

		#lecture du fichier de sauvegarde
		while fichierDeSauvegarde.get_position() < fichierDeSauvegarde.get_length():
			donneesSauvegardees = JSON.parse_string(fichierDeSauvegarde.get_line())

		fichierDeSauvegarde.close()

		#distribution des objets dans l'inventaire
		distribuerObjetsSauvegardes(donneesSauvegardees)
	pass


##Permet de distribuer les objets sauvegarder dans l'inventaire
func distribuerObjetsSauvegardes(donneesSauvegardees) -> void:
	var listeObjetsSauvegardes : Array = donneesSauvegardees.get("listeContenu")
	var i : int = 0
	var indexListeInventaire : int = 0
	var nomObjet : String
	var metadataObjet : Variant

	while i < listeObjetsSauvegardes.size():
		nomObjet = listeObjetsSauvegardes[i]
		metadataObjet = listeObjetsSauvegardes[i+1]

		listeInventaire.add_item(nomObjet)
		listeInventaire.set_item_metadata(indexListeInventaire, metadataObjet)

		indexListeInventaire += 1
		i += 2
	pass


##Permet de sauvegarder le contenu d'un inventaire
func sauvegarderContenuInventaire() -> void:
	var donneesSauvegardees : Dictionary = creerDonneesSauvegardees()
	var fichierDeSauvegarde = FileAccess.open(EMPLACEMENT_FICHIER_SAUVEGARDE, FileAccess.WRITE)

	var jsonSauvegarde = JSON.stringify(donneesSauvegardees)

	fichierDeSauvegarde.store_string(jsonSauvegarde)

	fichierDeSauvegarde.close()
	pass


##Permet de creer les donnees qui seront sauvegardees
func creerDonneesSauvegardees() -> Dictionary:
	var donneesSauvegardees = {
		"listeContenu": getListeContenuInventaire(),
		}
	return donneesSauvegardees


##Permet d'obtenir la liste d'objet contenu dans un inventaire
func getListeContenuInventaire():
	var longueurListe : int =  listeInventaire.item_count

	var listeContenu : Array
	var nomObjet : String
	var metadataObjet : Variant
	var i : int = 0

	#copier chaque objet de la liste de l'inventaire et placer la copie dans une nouvelle liste
	while i < longueurListe:
		nomObjet = listeInventaire.get_item_text(i)
		metadataObjet = listeInventaire.get_item_metadata(i)
		listeContenu.push_back(nomObjet)
		listeContenu.push_back(metadataObjet)
		i += 1
	
	#return la liste formee dans la boucle while
	return listeContenu


#-------------------------------------------------------------------------------------------
#Methode abstraite selectionnerObjet() etant connecte au signal item_clicked de ItemList
#Permettant d'effectuer une ou des actions lorsqu'un objet dans l'inventaire est selectionne
#-------------------------------------------------------------------------------------------
