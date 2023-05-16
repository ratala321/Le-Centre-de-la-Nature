extends Node

func _ready():
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)


func _process(delta):
	if Input.is_key_pressed(KEY_Q):
		get_tree().call_group("InterfaceEnJeu", "cacherInterface")
