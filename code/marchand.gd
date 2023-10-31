class_name Marchand
extends Node3D


var client_en_cours : JoueurCanard


func _ready():
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)


func _physics_process(delta):
	if Input.is_key_pressed(KEY_Q) and get_node("DialoguesMarchand").visible:
		_effectuer_procedure_cacher_interface_dialogue()
		
	if client_en_cours:
		client_en_cours.progresser_animation_joueur(delta)


func effectuer_interaction_initiale_avec_joueur(joueur : JoueurCanard) -> void:
	_immobiliser_joueur(joueur)

	_effectuer_procedure_afficher_interface_dialogue()


func _immobiliser_joueur(joueur : JoueurCanard) -> void:
	# Attendre la fin de l'animation d'interaction
	await joueur.controleur_animation_joueur.animation_finished
	
	joueur.arreter_mouvement()


func _effectuer_procedure_afficher_interface_dialogue() -> void:
	get_node("DialoguesMarchand").show()
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED


func _effectuer_procedure_cacher_interface_dialogue() -> void:
	get_node("DialoguesMarchand").hide()
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
