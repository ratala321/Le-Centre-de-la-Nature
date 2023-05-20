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

#METHODE ABSTRAITE pour que la selection d'un objet effectue les actions voulues.
#Par exemple, lors de la selection d'un objet dans un coffre,
#transferer cet objet vers l'inventaire.
#func selectionnerObjet(indexObjet, positionClic, indexBouttonSouris) -> void:
