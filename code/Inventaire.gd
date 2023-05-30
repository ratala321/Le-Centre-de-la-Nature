class_name abstractInventaire extends Control

@onready var listeInventaire : ItemList = get_node("ItemList")
@onready var proprioInventaire = get_parent()
@onready var nomFichierSauvegarde : String = proprioInventaire.name
@onready var EMPLACEMENT_FICHIER_SAUVEGARDE : String = "user://" + nomFichierSauvegarde + ".txt"

##inventaire vers lequel les transferts sont procedes
var inventaireDestination

const nomNodeJoueur : String = "JoueurCanard"

func _ready():
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)
	chargerContenuInventaire()


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
func chargerContenuInventaire() -> void:
	#Ajouter chacun des objets dans la listeContenu dans le ItemList.
	pass


##Permet de sauvegarder le contenu d'un inventaire
func sauvegarderContenuInventaire() -> void:
	var donneesSauvegardees = creerDonneesSauvegardees()
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
	var longueurListe =  listeInventaire.item_count
	var i = 0

		#copier chaque objet de la liste et placer la copie dans une liste
	while i < longueurListe:
		i += 1
	
	#return la liste formee dans la boucle while
	pass


#-------------------------------------------------------------------------------------------
#Methode abstraire selectionnerObjet() etant connecte au signal item_clicked de ItemList
#Permettant d'effectuer une ou des actions lorsqu'un objet dans l'inventaire est selectionne
#-------------------------------------------------------------------------------------------
