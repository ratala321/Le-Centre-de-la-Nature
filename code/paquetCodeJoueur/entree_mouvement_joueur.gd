class_name EntreeMouvementJoueur
extends RefCounted


var _joueur : JoueurCanard
func _init(joueur : JoueurCanard):
	self._joueur = joueur


func saisir_entree_mouvement_joueur() -> FacteursMouvementJoueur:
	var facteurs_actuel : FacteursMouvementJoueur

	if _joueur.peut_se_mouvoir():
		facteurs_actuel = _effectuer_procedure_saisie_entree()

	return facteurs_actuel


func _effectuer_procedure_saisie_entree() -> FacteursMouvementJoueur:
	var direction_joueur_brut : Vector3 = _saisir_entree_direction()

	var index_facteurs_rotation : int = _calculer_index_facteurs_rotation(direction_joueur_brut)

	var vitesse_esquive_joueur : int = _saisir_entree_esquive()

	var direction_joueur : Vector3 =(
		_effectuer_procedure_ajustement_direction_joueur(direction_joueur_brut))

	return FacteursMouvementJoueur.new(index_facteurs_rotation, vitesse_esquive_joueur, direction_joueur)



func _saisir_entree_direction() -> Vector3:
	var entree_direction_joueur : Vector3 = _saisir_entree_direction_horizontale()

	entree_direction_joueur.y = _saisir_entree_direction_verticale()

	return entree_direction_joueur


const VITESSE_ESQUIVE_ABSENTE : int = 1
const VITESSE_ESQUIVE_APPLIQUEE : int = 50
func _saisir_entree_esquive() -> int:
	var vitesse_esquive : int = VITESSE_ESQUIVE_ABSENTE

	if Input.is_action_pressed("esquive") and _joueur_peut_esquiver():
		_relancer_chronometre_esquive()
		vitesse_esquive = VITESSE_ESQUIVE_APPLIQUEE
	
	return vitesse_esquive


func _effectuer_procedure_ajustement_direction_joueur(direction_joueur_brut : Vector3) -> Vector3:
	var direction_joueur_ajuste : Vector3 =(
		_ajuster_direction_avant_selon_camera(direction_joueur_brut))
	
	direction_joueur_ajuste = _normaliser_direction_diagonale(direction_joueur_ajuste)

	return direction_joueur_ajuste


## Creation d'une valeur d'index unique pour chaque direction de rotation
## Exemple direction droite = Vecteur(-1,0,0) -> resultat = -1 + 3 * 0 + 4 = 3
func _calculer_index_facteurs_rotation(direction_joueur_brut : Vector3) -> int:
	return direction_joueur_brut.x + 3 * direction_joueur_brut.z + 4


const DIRECTION_DROITE : int = -1
const DIRECTION_GAUCHE : int = 1
const DIRECTION_AVANT : int = 1
const DIRECTION_ARRIERE : int = -1
func _saisir_entree_direction_horizontale() -> Vector3:
	var direction_joueur_horizontale : Vector3 = Vector3.ZERO

	if Input.is_action_pressed("mouvement_avant"):
		direction_joueur_horizontale.z = DIRECTION_AVANT

	if Input.is_action_pressed("mouvement_arriere"):
		direction_joueur_horizontale.z = DIRECTION_ARRIERE
	
	if Input.is_action_pressed("mouvement_droite"):
		direction_joueur_horizontale.x = DIRECTION_DROITE
	
	if Input.is_action_pressed("mouvement_gauche"):
		direction_joueur_horizontale.x = DIRECTION_GAUCHE
	
	return direction_joueur_horizontale


func _saisir_entree_direction_verticale() -> float:
	var direction_verticale_joueur : float = 0

	if Input.is_action_pressed("saut"):
		direction_verticale_joueur = 1
	
	return direction_verticale_joueur


func _joueur_peut_esquiver() -> bool:
	return _joueur.chronometre_esquive.is_stopped()


const INTERVALLE_ESQUIVE_JOUEUR : int = 3
func _relancer_chronometre_esquive() -> void:
	_joueur.chronometre_esquive.start(INTERVALLE_ESQUIVE_JOUEUR)


func _ajuster_direction_avant_selon_camera(direction_joueur_brut : Vector3) -> Vector3:
	var direction_avant : Vector3 = _calculer_direction_avant()

	return direction_joueur_brut.rotated(Vector3(0, 1, 0), direction_avant.y)


func _calculer_direction_avant() -> Vector3:
	return _joueur.axe_rotation_camera.global_rotation


func _normaliser_direction_diagonale(direction_joueur : Vector3) -> Vector3:
	if _normalisation_est_necessaire(direction_joueur):
		direction_joueur = direction_joueur.normalized()
	
	return direction_joueur


func _normalisation_est_necessaire(vecteur_non_normalise) -> bool:
	return vecteur_non_normalise != Vector3.ZERO
