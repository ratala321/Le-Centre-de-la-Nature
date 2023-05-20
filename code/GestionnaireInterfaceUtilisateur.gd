extends Node

@onready var joueur = get_node("../JoueurCanard")


func _ready():
	set_process_mode(PROCESS_MODE_ALWAYS)


func _process(delta):
	cacherInterface()

##permet de cacher l'ensemble des interfaces affichés et continuer le jeu
func cacherInterface() -> void:
	if Input.is_key_pressed(KEY_Q):
		get_tree().call_group("InterfaceEnJeu", "cacherInterface")
