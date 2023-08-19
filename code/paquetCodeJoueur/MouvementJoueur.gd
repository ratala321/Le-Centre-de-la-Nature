class_name MouvementJoueur extends Node


var joueur : JoueurCanard
func _init(joueur : JoueurCanard):
	self.joueur = joueur


func effectuerProcedureAppplicationMouvement(delta, facteursMouvementJoueur : FacteursMouvementJoueur):
	#tourne le joueur face a la direction de son mouvement
	_appliquerRotationJoueur(facteursMouvementJoueur.vecteurDirectionJoueurBrut)

	#application des animations en fonction de la direction du mouvement
	_appliquerAnimationMouvement(facteursMouvementJoueur.vecteurDirectionJoueur)

	#application du mouvement
	_appliquerMouvement(delta, facteursMouvementJoueur.vecteurDirectionJoueur,
	facteursMouvementJoueur.vitesseEsquiveJoueur)


##valeur du facteur d'interpolation de l'angle de rotation du joueur
const INTERPOLATION_ROTATION_JOUEUR : float = 0.25
##permet d'effectuer la rotation du joueur en fonction de la direction du mouvement horizontal
##c-a-d le joueur fera face a la direction de son mouvement
func _appliquerRotationJoueur(directionJoueur : Vector3) -> void:
	#vecteur de la rotation appliquee au joueur
	var vecteurRotation : Vector3
	#vecteur de la rotation de la camera avant que la rotation soit appliquee
	var vecteurRotationInitialCamera

	#effectue la rotation en fonction de la direction du mouvement horizontal
	if directionJoueur != Vector3.ZERO:
		vecteurRotation = _determinerVecteurRotation(directionJoueur)
		vecteurRotationInitialCamera = joueur.axeRotationCamera.get_global_rotation_degrees()
		#tourne le joueur
		joueur.rotation.y = lerp_angle(joueur.rotation.y, vecteurRotation.y, INTERPOLATION_ROTATION_JOUEUR)
		#conserve la rotation de la camera
		joueur.axeRotationCamera.conserverRotationCamera(vecteurRotationInitialCamera)


const DIRECTION_AVANT : int = 1

const DIRECTION_DROITE_VECTEUR : Vector3 = Vector3(-1, 0, 0)
const DIRECTION_GAUCHE_VECTEUR : Vector3 = Vector3(1, 0, 0)
const DIRECTION_AVANT_VECTEUR : Vector3 = Vector3(0, 0, 1)
const DIRECTION_ARRIERE_VECTEUR : Vector3 = Vector3(0, 0, -1)
const DIRECTION_DIAGONALE_AVANT_DROITE_VECTEUR : Vector3 = Vector3(-1, 0, 1)
const DIRECTION_DIAGONALE_AVANT_GAUCHE_VECTEUR : Vector3 = Vector3(1, 0, 1)
const DIRECTION_DIAGONALE_ARRIERE_DROITE_VECTEUR : Vector3 = Vector3(-1, 0, -1)
const DIRECTION_DIAGONALE_ARRIERE_GAUCHE_VECTEUR : Vector3 = Vector3(1, 0, -1)

const FACTEUR_ROTATION_DROITE : float = -PI/2
const FACTEUR_ROTATION_GAUCHE : float = PI/2
const FACTEUR_ROTATION_AVANT : float = 2*PI
const FACTEUR_ROTATION_ARRIERE : float = PI
const FACTEUR_ROTATION_DIAGONALE_AVANT_DROITE : float = -PI/4
const FACTEUR_ROTATION_DIAGONALE_AVANT_GAUCHE : float = PI/4
const FACTEUR_ROTATION_DIAGONALE_ARRIERE_DROITE : float = -3*PI/4
const FACTEUR_ROTATION_DIAGONALE_ARRIERE_GAUCHE : float = 3*PI/4
##permet de determiner quel vecteur de rotation sera utilise par
##la fonction appliquerRotationJoueur
func _determinerVecteurRotation(directionJoueur : Vector3) -> Vector3:
	#vecteur de la rotation applique en fonction de la direction
	var vecteurRotation : Vector3 = Vector3.ZERO
	vecteurRotation.y = joueur.axeRotationCamera.get_global_rotation().y
	#contient la direction vers laquelle la camera pointe
	var directionAvant : Vector3 = Vector3(0, 0, DIRECTION_AVANT).rotated(Vector3(0, 1 ,0), vecteurRotation.y)

	if directionJoueur == DIRECTION_ARRIERE_VECTEUR:
		vecteurRotation.y += FACTEUR_ROTATION_ARRIERE
	elif directionJoueur == DIRECTION_AVANT_VECTEUR:
		vecteurRotation.y = vecteurRotation.y
	elif directionJoueur == DIRECTION_DROITE_VECTEUR:
		vecteurRotation.y += FACTEUR_ROTATION_DROITE
	elif directionJoueur == DIRECTION_GAUCHE_VECTEUR:
		vecteurRotation.y += FACTEUR_ROTATION_GAUCHE
	elif directionJoueur == DIRECTION_DIAGONALE_AVANT_DROITE_VECTEUR:
		vecteurRotation.y += FACTEUR_ROTATION_DIAGONALE_AVANT_DROITE
	elif directionJoueur == DIRECTION_DIAGONALE_AVANT_GAUCHE_VECTEUR:
		vecteurRotation.y += FACTEUR_ROTATION_DIAGONALE_AVANT_GAUCHE
	elif directionJoueur == DIRECTION_DIAGONALE_ARRIERE_DROITE_VECTEUR:
		vecteurRotation.y += FACTEUR_ROTATION_DIAGONALE_ARRIERE_DROITE
	elif directionJoueur == DIRECTION_DIAGONALE_ARRIERE_GAUCHE_VECTEUR:
		vecteurRotation.y += FACTEUR_ROTATION_DIAGONALE_ARRIERE_GAUCHE
	
	return vecteurRotation
		

const ANIMATION_SAUT : String = "Jump"
const ANIMATION_MARCHE : String = "Walk"
const ANIMATION_IDLE : String = "Dance"

##vitesse d'execution des animations en general
const VITESSE_ANIMATION_INITIALE : int = 1
##vitesse d'execution de l'animation liee a l'interaction
const VITESSE_ANIMATION_INTERACTION : float = 1.5
##vitesse d'execution de l'animation liee au saut
const VITESSE_ANIMATION_SAUT : float = 1.9
##permet d'appliquer les animations liees au mouvement
func _appliquerAnimationMouvement(vecteurDirectionJoueur : Vector3) -> void:
	#application de l'animation de saut
	if mouvementJoueurEstSaut(): 
		joueur.animationJoueur.appliquerAnimation(ANIMATION_SAUT)
		joueur.animationJoueur.ajusterVitesseAnimation(VITESSE_ANIMATION_SAUT)

	#application de l'animation de marche
	elif mouvementJoueurEstMarche(vecteurDirectionJoueur):
		joueur.animationJoueur.ajusterVitesseAnimation(VITESSE_ANIMATION_INITIALE)
		joueur.animationJoueur.appliquerAnimation(ANIMATION_MARCHE)

	#application de l'animation lorsqu'il n'y a aucun mouvement
	else:
		joueur.animationJoueur.ajusterVitesseAnimation(VITESSE_ANIMATION_INITIALE)
		joueur.animationJoueur.appliquerAnimation(ANIMATION_IDLE)

func mouvementJoueurEstSaut() -> bool:
	return !_joueurEstAuSol() and joueur.animationJoueur.has_animation(ANIMATION_SAUT)


func mouvementJoueurEstMarche(vecteurDirectionJoueur) -> bool:
	return vecteurDirectionJoueur != Vector3.ZERO and joueur.animationJoueur.has_animation(ANIMATION_MARCHE)


@export var VITESSE_JOUEUR = 450
##permet d'appliquer le mouvement au personnage du joueur
func _appliquerMouvement(delta, directionJoueur, vitesseEsquiveJoueur) -> void:
	#application du saut
	if (_joueurAvaitSaisiBouttonSaut(directionJoueur) and _joueurEstAuSol()):
		_appliquerSaut(delta)

	#application du mouvement horizontal sur l'axe x
	joueur.velocity.x = directionJoueur.x * VITESSE_JOUEUR * delta * vitesseEsquiveJoueur
	#application du mouvement horizontal sur l'axe z
	joueur.velocity.z = directionJoueur.z * VITESSE_JOUEUR * delta * vitesseEsquiveJoueur

	joueur.move_and_slide()


func _joueurAvaitSaisiBouttonSaut(vecteurDirectionJoueur : Vector3) -> bool:
	return vecteurDirectionJoueur.y != 0


##determine la hauteur maximale du joueur lors d'un saut
const HAUTEUR_MAXIMALE_SAUT : int = 4250
##?inversee pour quelconque raison : plus c'est petit, plus c'est long?ajustement necessaire
const TEMPS_HAUTEUR_MAXIMALE_SAUT : int = 7
#force de saut
const IMPULSION_SAUT_JOUEUR : int = 2 * HAUTEUR_MAXIMALE_SAUT / TEMPS_HAUTEUR_MAXIMALE_SAUT
##effet sonore du saut du joueur
var SON_SAUT : AudioStream = load("res://sons/jump_8bits.mp3")
#permet d'appliquer le saut au personnage du joueur
func _appliquerSaut(delta) -> void:
	#application du saut
	joueur.velocity.y = IMPULSION_SAUT_JOUEUR * delta

	#application de l'effet sonore associe au saut
	joueur.audioJoueur.appliquerSon(SON_SAUT)


##permet d'evaluer si le joueur est au sol
func _joueurEstAuSol() -> bool:
	return joueur.raycastJoueurSol.is_colliding()

