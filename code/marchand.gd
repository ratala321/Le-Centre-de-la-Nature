class_name Marchand
extends Node3D


## Angle de vue, lors du marchandage avec le joueur, etant placee dans la scene du niveau.
@export var angle_vue_marchand : Camera3D

## Temps de transition de la camera en cours vers l'angle de vue[br]
## ou de l'angle de vue vers la camera du joueur.
@export var temps_transition_cameras : float = 1.5


func _ready():
	var dialogues_marchand = get_node("DialoguesMarchand")
	dialogues_marchand.connect("boutton_quitter_clique", _liberer_joueur_contraintes_interaction)


func _physics_process(delta):
	if client_en_cours:
		client_en_cours.progresser_animation_joueur(delta)


var client_en_cours : JoueurCanard

var camera_joueur : Camera3D

func effectuer_interaction_initiale_avec_joueur(joueur : JoueurCanard) -> void:
	client_en_cours = joueur

	_contraindre_joueur_pour_interaction(joueur)

	get_node("DialoguesMarchand").afficher_dialogues_marchand()


## Libere le joueur des contraintes etablies pour permettre une interaction fluide avec le marchand.
func _liberer_joueur_contraintes_interaction() -> void:
	await _lancer_transition_vers_camera_joueur()

	client_en_cours.relancer_mouvement()


## Etablit des contraintes au joueur afin de permettre une interaction fluide avec le marchand.
func _contraindre_joueur_pour_interaction(joueur : JoueurCanard) -> void:
	_immobiliser_joueur(joueur)

	camera_joueur = _obtenir_camera_joueur(joueur)

	_lancer_transition_vers_angle_de_vue(camera_joueur)


func _immobiliser_joueur(joueur : JoueurCanard) -> void:
	# Attendre la fin de l'animation d'interaction
	await joueur.controleur_animation_joueur.animation_finished

	joueur.arreter_mouvement()


func _lancer_transition_vers_camera_joueur() -> void:
	await TransitionCamera3d.effectuer_transition_basique_camera_3d(
		angle_vue_marchand,
		camera_joueur,
		temps_transition_cameras / 2
	)


func _lancer_transition_vers_angle_de_vue(en_cours_utilisation : Camera3D) -> void:
	TransitionCamera3d.effectuer_transition_basique_camera_3d(
			en_cours_utilisation,
			angle_vue_marchand,
			temps_transition_cameras
	)


func _obtenir_camera_joueur(joueur : JoueurCanard) -> Camera3D:
	return joueur.camera_joueur
