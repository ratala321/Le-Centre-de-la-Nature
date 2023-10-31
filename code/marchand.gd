class_name Marchand
extends Node3D


var client_en_cours : Node


func _ready():
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)


func _physics_process(_delta):
	if Input.is_key_pressed(KEY_Q) and get_node("DialoguesMarchand").visible:
		_effectuer_procedure_cacher_interface_dialogue()


func effectuer_interaction_initiale_avec_joueur(_joueur : JoueurCanard) -> void:
	# TODO empecher_mouvement_client(client)

	_effectuer_procedure_afficher_interface_dialogue()
	

func _effectuer_procedure_afficher_interface_dialogue() -> void:
	get_node("DialoguesMarchand").show()
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED


func _effectuer_procedure_cacher_interface_dialogue() -> void:
	get_node("DialoguesMarchand").hide()
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
