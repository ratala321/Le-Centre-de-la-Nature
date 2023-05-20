class_name Inventaire extends Control

@onready var listeInventaire = get_node("ItemList")


func _ready():
	listeInventaire.connect("item_clicked", selectionnerObjet)
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


##
func selectionnerObjet(indexObjet, positionClic, indexBouttonSouris) -> void:
	print("CLIC!")
	pass
