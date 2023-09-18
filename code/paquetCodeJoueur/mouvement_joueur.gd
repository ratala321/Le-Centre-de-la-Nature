class_name MouvementJoueur
extends RefCounted


var _joueur : JoueurCanard
func _init(joueur : JoueurCanard):
	self._joueur = joueur


func effectuer_procedure_appplication_mouvement(delta, facteurs_mouvement_joueur : FacteursMouvementJoueur):
	_effectuer_processus_application_gravite(delta)

	if _joueur.peut_se_mouvoir():
		_appliquer_rotation_joueur(facteurs_mouvement_joueur.index_facteurs_rotation)

		_appliquer_animation_mouvement(facteurs_mouvement_joueur.direction_joueur)

		_appliquer_mouvement(delta, facteurs_mouvement_joueur.direction_joueur, facteurs_mouvement_joueur.vitesse_esquive_joueur)


const GRAVITE_SOL_JOUEUR : int = -100
const GRAVITE_SAUT_JOUEUR : int = -60
func _effectuer_processus_application_gravite(delta) -> void:
	if _joueur_est_en_saut():
		_appliquer_gravite(GRAVITE_SAUT_JOUEUR, delta)
	else:
		_appliquer_gravite(GRAVITE_SOL_JOUEUR, delta)
	
	_joueur.move_and_slide()


func _appliquer_rotation_joueur(index_facteurs_rotation : int) -> void:
	if _joueur_est_en_mouvement(index_facteurs_rotation):
		var rotation_initiale_camera : Vector3 =(
			_joueur.axe_rotation_camera.global_rotation_degrees
		)
		
		var angle_rotation : float = _calculer_angle_rotation(index_facteurs_rotation)

		_joueur.rotation = Vector3(_joueur.rotation.x, angle_rotation, _joueur.rotation.z)

		_conserver_rotation_initiale_camera(rotation_initiale_camera)


const ANIMATION_SAUT : String = "Jump"
const ANIMATION_MARCHE : String = "Walk"
const ANIMATION_IDLE : String = "Idle"
const VITESSE_ANIMATION_INITIALE : int = 1
const VITESSE_ANIMATION_SAUT : float = 1.9
func _appliquer_animation_mouvement(direction_joueur : Vector3) -> void:
	if _animation_saut_peut_etre_jouee():
		_joueur.animation_joueur.play(ANIMATION_SAUT)
		_joueur.animation_joueur.speed_scale = VITESSE_ANIMATION_SAUT
	elif _animation_marche_peut_etre_jouee(direction_joueur):
		_joueur.animation_joueur.speed_scale = VITESSE_ANIMATION_INITIALE
		_joueur.animation_joueur.play(ANIMATION_MARCHE)
	else:
		_joueur.animation_joueur.speed_scale = VITESSE_ANIMATION_INITIALE
		_joueur.animation_joueur.play(ANIMATION_IDLE)


func _appliquer_mouvement(delta, direction_joueur : Vector3, vitesse_esquive_joueur : int) -> void:
	_appliquer_mouvement_vertical(delta, direction_joueur)

	_appliquer_mouvement_horizontal(delta, direction_joueur, vitesse_esquive_joueur)


func _joueur_est_en_saut() -> bool:
	return _joueur.velocity.y > 0


func _appliquer_gravite(constante_gravite : int, delta) -> void:
	var velocite_gravite : float = _joueur.velocity.y + constante_gravite * delta

	_joueur.velocity = Vector3(_joueur.velocity.x, velocite_gravite, _joueur.velocity.z)


const VALEUR_INDEX_AUCUN_MOUVEMENT : int = 4
func _joueur_est_en_mouvement(index_facteurs_rotation : int) -> bool:
	return index_facteurs_rotation != VALEUR_INDEX_AUCUN_MOUVEMENT


const INTERPOLATION_ROTATION_JOUEUR : float = 0.25
func _calculer_angle_rotation(index_facteurs_rotation : int) -> float:
	return lerp_angle(_joueur.rotation.y,
		_calculer_facteur_rotation(index_facteurs_rotation),
		INTERPOLATION_ROTATION_JOUEUR)


const FACTEURS_ROTATION : Array =(
	[
		-3 * PI / 4, # rotation diagonale arriere droite
		PI, # rotation arriere
		3 * PI / 4, # rotation arriere gauche
		(-PI) / 2, # rotation droite
		0,
		PI / 2, # rotation gauche
		(-PI) / 4, # rotation diagonale avant droite
		2 * PI, # rotation avant
		PI / 4 # rotation diagonale avant gauche
	]
)
func _calculer_facteur_rotation(index_facteurs_rotation : int) -> float:
	var facteur_rotation : float = FACTEURS_ROTATION[index_facteurs_rotation]

	facteur_rotation =(
		_ajustement_facteur_rotation_selon_direction_camera(facteur_rotation)
	)
	
	return facteur_rotation


func _ajustement_facteur_rotation_selon_direction_camera(facteur_rotation : float) -> float:
	return facteur_rotation + _joueur.axe_rotation_camera.global_rotation.y


func _conserver_rotation_initiale_camera(rotation_initiale_camera : Vector3) -> void:
	_joueur.axe_rotation_camera.global_rotation_degrees = rotation_initiale_camera


func _appliquer_mouvement_vertical(delta, direction_joueur : Vector3) -> void:
	if _joueur_avait_saisi_boutton_saut(direction_joueur) and _joueur.est_au_sol():
		_appliquer_saut(delta)


func _joueur_avait_saisi_boutton_saut(direction_joueur : Vector3) -> bool:
	return direction_joueur.y != 0


const HAUTEUR_MAXIMALE_SAUT : int = 4250
const TEMPS_HAUTEUR_MAXIMALE_SAUT : int = 7
@warning_ignore("integer_division")
const IMPULSION_SAUT_JOUEUR : int = 2 * HAUTEUR_MAXIMALE_SAUT / TEMPS_HAUTEUR_MAXIMALE_SAUT
const SON_SAUT : AudioStream = preload("res://sons/jump_8bits.mp3")
func _appliquer_saut(delta) -> void:
	_joueur.velocity =(
		Vector3(_joueur.velocity.x, IMPULSION_SAUT_JOUEUR * delta, _joueur.velocity.z)
	)
	
	_joueur.audio_joueur.stream = SON_SAUT
	_joueur.audio_joueur.play()


func _appliquer_mouvement_horizontal(delta, direction_joueur : Vector3,
		vitesse_esquive_joueur : int) -> void:
	var velocite : Vector3 =(
		Vector3(_calculer_velocite_x(delta, direction_joueur, vitesse_esquive_joueur),
			_joueur.velocity.y,
			_calculer_velocite_z(delta, direction_joueur, vitesse_esquive_joueur))
	)

	_joueur.velocity = velocite

	_joueur.move_and_slide()


@export var vitesse_joueur_base : int = 450
func _calculer_velocite_x(delta, direction_joueur : Vector3,
		vitesse_esquive_joueur : int) -> float:
	return direction_joueur.x * vitesse_joueur_base * delta * vitesse_esquive_joueur


func _calculer_velocite_z(delta, direction_joueur : Vector3,
		vitesse_esquive_joueur : int) -> float:
	return direction_joueur.z * vitesse_joueur_base * delta * vitesse_esquive_joueur


func _animation_saut_peut_etre_jouee() -> bool:
	return not _joueur.est_au_sol() and _joueur.animation_joueur.has_animation(ANIMATION_SAUT)


func _animation_marche_peut_etre_jouee(direction_joueur : Vector3) -> bool:
	return (
		direction_joueur != Vector3.ZERO and 
			_joueur.animation_joueur.has_animation(ANIMATION_MARCHE)
	)
