class_name Marchand
extends Node3D


## Angle de vue, lors du marchandage avec le joueur, etant placee dans la scene du niveau.
@export var angle_vue_marchand : Camera3D

## Temps de transition de la camera en cours vers l'angle de vue.
@export var temps_transition_angle_vue : float = 1.5


func _ready():
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)


func _physics_process(delta):
	if Input.is_key_pressed(KEY_Q) and get_node("DialoguesMarchand").visible:
		_effectuer_procedure_cacher_interface_dialogue()
		
	if client_en_cours:
		client_en_cours.progresser_animation_joueur(delta)


var client_en_cours : JoueurCanard

var camera_joueur : Camera3D

func effectuer_interaction_initiale_avec_joueur(joueur : JoueurCanard) -> void:
	client_en_cours = joueur
	
	_immobiliser_joueur(joueur)
	
	camera_joueur = _obtenir_camera_joueur(joueur)
	
	_lancer_transition_vers_angle_de_vue(camera_joueur)
	
	_effectuer_procedure_afficher_interface_dialogue()


func _immobiliser_joueur(joueur : JoueurCanard) -> void:
	# Attendre la fin de l'animation d'interaction
	await joueur.controleur_animation_joueur.animation_finished
	
	joueur.arreter_mouvement()


func _obtenir_camera_joueur(joueur : JoueurCanard) -> Camera3D:
	return joueur.camera_joueur


func _lancer_transition_vers_angle_de_vue(en_cours_utilisation : Camera3D) -> void:
	TransitionCamera3d.effectuer_transition_basique_camera_3d(
			en_cours_utilisation,
			angle_vue_marchand,
			temps_transition_angle_vue
	)


func _effectuer_procedure_afficher_interface_dialogue() -> void:
	get_node("DialoguesMarchand").afficher_dialogues_marchand()
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED


func _effectuer_procedure_cacher_interface_dialogue() -> void:
	get_node("DialoguesMarchand").cacher_dialogues_marchand()
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
