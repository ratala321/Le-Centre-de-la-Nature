class_name Coffre
extends AbstractObjetInteractif


func _ready():
	super._ready()


func effecuter_interaction(interacteur : Node) -> void:
	if interacteur.has_node("Inventaire"):
		#TODO
	pass
