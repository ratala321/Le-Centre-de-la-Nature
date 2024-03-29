class_name Camera3dJoueur
extends Node3D


@export var sensibilite_camera : float = 1

## Valeur de la rotation verticale de la camera
var rotation_verticale_camera : float = 0
## Valeur de la rotation horizontale de la camera
var rotation_horizontale_camera : float = 0


func _ready():
	## Isole la souris dans la fenetre
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Camera3DJoueur.make_current()


var _jeu_en_pause : bool = false

func _notification(what):
	if what == NOTIFICATION_PAUSED:
		_jeu_en_pause = true

	if what == NOTIFICATION_UNPAUSED:
		_jeu_en_pause = false


func _input(event):
	# Mouvement de la camera basee sur la direction de la souris
	if not _jeu_en_pause and event is InputEventMouseMotion:
		var direction_mouvement_souris : Vector2 = event.relative * sensibilite_camera

		_actualiser_valeur_rotation_camera(direction_mouvement_souris)

		_tourner_camera_souris_joueur()


func _tourner_camera_souris_joueur() -> void:
	global_rotation_degrees.x = rotation_verticale_camera
	global_rotation_degrees.y = rotation_horizontale_camera


const ROTATION_VERTICALE_MAXIMALE_HAUT : float = 26
const ROTATION_VERTICALE_MAXIMALE_BAS : float = -67
const ROTATION_HORIZONTALE_INITIALE : float = 180
const TOUR_HORIZONTAL_GAUCHE_COMPLET : float = 540
const TOUR_HORIZONTAL_DROITE_COMPLET : float = -180
func _actualiser_valeur_rotation_camera(direction_mouvement_souris : Vector2) -> void:
	rotation_verticale_camera += direction_mouvement_souris.y

	rotation_verticale_camera = clampf(rotation_verticale_camera,
		ROTATION_VERTICALE_MAXIMALE_BAS, ROTATION_VERTICALE_MAXIMALE_HAUT)

	rotation_horizontale_camera -= direction_mouvement_souris.x


## Permet de conserver la rotation de la camera malgre la rotation du joueur
func conserver_rotation_camera(vecteur_rotation) -> void:
	set_global_rotation_degrees(vecteur_rotation)
