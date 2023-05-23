class_name abstractInventaire extends Control

@onready var listeInventaire = get_node("ItemList")

var inventaireDestination

func _ready():
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)


##permet de montrer l'interface	
func montrerInterface() -> void:
	show()
	Input.set_mouse_mode(3)
	get_tree().paused = true


##permet de cacher l'interface
func cacherInterface() -> void:
	hide()
	Input.set_mouse_mode(2)
	get_tree().paused = false


##permet de creer une reference a l'inventaire dans lequel les objets seront transferes
func ajouterReferenceInventaireDestination(referenceInventaireDestination):
	inventaireDestination = referenceInventaireDestination
	pass

##permet d'effectuer le transfert d'un objet de l'inventaire joueur
##vers l'inventaire de destination
func transfererInventaire(indexObjet : int) -> void:
	var listeInventaireDestination : ItemList = inventaireDestination.get_node("ItemList")
	print("CLIC! dans " + self.name)
	print(listeInventaire.get_item_text(indexObjet))
	listeInventaireDestination.add_item(listeInventaire.get_item_text(indexObjet))
	listeInventaire.remove_item(indexObjet)


#-------------------------------------------------------------------------------------------
#Methode abstraire selectionnerObjet() etant connecte au signal item_clicked de ItemList
#permettant d'effectuer une ou des actions lorsqu'un objet dans l'inventaire est selectionne
#-------------------------------------------------------------------------------------------
