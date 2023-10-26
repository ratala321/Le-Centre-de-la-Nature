class_name Marchand
extends Node3D


func _ready():
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)


func _physics_process(_delta):
	if Input.is_key_pressed(KEY_Q) and get_node("DialoguesMarchand").visible:
		_effectuer_procedure_cacher_interface_dialogue()


func effectuer_interaction(_interacteur : Node) -> void:
	_effectuer_procedure_afficher_interface_dialogue()
	

func _effectuer_procedure_afficher_interface_dialogue() -> void:
	get_node("DialoguesMarchand").show()
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	
	get_tree().paused = true


func _effectuer_procedure_cacher_interface_dialogue() -> void:
	get_node("DialoguesMarchand").hide()
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	get_tree().paused = false
