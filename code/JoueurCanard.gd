extends CharacterBody3D
class_name JoueurCanard

@export var vitesseJoueur = 450

##contient la reference au node de Timer nommee ChronometreEsquive du joueur
@onready var chronometreEsquive = get_node("ChronometreEsquive")
##contient la reference au node de RayCast3D nommee RayEstAuSol du joueur
@onready var raycastJoueurSol = get_node("RayEstAuSol")
##contient la reference au node d'AnimationPlayer du joueur
@onready var animationJoueur = get_node("KayKit_AnimatedCharacter_v13/AnimationPlayer")
##contient la reference au node d'AudioStreamPlayer du joueur
@onready var audioJoueur = get_node("AudioStreamPlayer")
##contient la reference au node d'AxeRotationCamera du joueur
@onready var axeRotationCamera = get_node("AxeRotationCamera")
##contient la reference au Gestionnaire d'interface utilisateur
@onready var gestionnaireInterfaceUtilisateur = get_node("../GestionnaireInterfaceUtilisateur")

##force gravitationnelle lorsque le joueur est au sol
const GRAVITE_SOL_JOUEUR : int = -100


#------------------------
#constantes liees au saut
#------------------------
##determine la hauteur maximale du joueur lors d'un saut
const HAUTEUR_MAXIMALE_SAUT : int = 4250
##?inversee pour quelconque raison : plus c'est petit, plus c'est long?ajustement necessaire
const TEMPS_HAUTEUR_MAXIMALE_SAUT : int = 7
##?pas encore utilisee
const TEMPS_DESCENTE_SAUT : int = 2
##force gravitationnelle lorsque le joueur est en saut et se dirige vers le haut
const GRAVITE_SAUT_JOUEUR : int = -60
##force l'impulsion du saut du joueur
const IMPULSION_SAUT_JOUEUR : int = 2 * HAUTEUR_MAXIMALE_SAUT / TEMPS_HAUTEUR_MAXIMALE_SAUT



#-----------------------------------
#constantes de direction horizontale
#-----------------------------------
##valeur du vecteur correspodant a la direction droite
const DIRECTION_DROITE_VECTEUR : Vector3 = Vector3(-1, 0, 0)
##valeur du vecteur correspodant a la direction gauche
const DIRECTION_GAUCHE_VECTEUR : Vector3 = Vector3(1, 0, 0)
##valeur du vecteur correspodant a la direction avant
const DIRECTION_AVANT_VECTEUR : Vector3 = Vector3(0, 0, 1)
##valeur du vecteur correspodant a la direction arriere
const DIRECTION_ARRIERE_VECTEUR : Vector3 = Vector3(0, 0, -1)
##valeur du vecteur correspodant a la direction diagonale avant et droite
const DIRECTION_DIAGONALE_AVANT_DROITE_VECTEUR : Vector3 = Vector3(-1, 0, 1)
##valeur du vecteur correspodant a la direction diagonale avant et gauche
const DIRECTION_DIAGONALE_AVANT_GAUCHE_VECTEUR : Vector3 = Vector3(1, 0, 1)
##valeur du vecteur correspodant a la direction diagonale arriere et droite
const DIRECTION_DIAGONALE_ARRIERE_DROITE_VECTEUR : Vector3 = Vector3(-1, 0, -1)
##valeur du vecteur correspodant a la direction diagonale arriere et gauche
const DIRECTION_DIAGONALE_ARRIERE_GAUCHE_VECTEUR : Vector3 = Vector3(1, 0, -1)


#----------------------
#constantes de rotation
#----------------------
##valeur du facteur d'interpolation de l'angle de rotation du joueur
const INTERPOLATION_ROTATION_JOUEUR : float = 0.25
##valeur du vecteur de rotation du joueur lors d'un deplacement vers la droite
const ROTATION_DROITE_VECTEUR : Vector3 = Vector3(0,-PI/2,0)
##valeur du vecteur de rotation du joueur lors d'un deplacement vers la gauche
const ROTATION_GAUCHE_VECTEUR : Vector3 = Vector3(0,PI/2,0)
##valeur du vecteur de rotation du joueur lors d'un deplacement vers l'avant
const ROTATION_AVANT_VECTEUR : Vector3 = Vector3(0,2*PI,0)
##valeur du vecteur de rotation du joueur lors d'un deplacement vers l'arriere
const ROTATION_ARRIERE_VECTEUR : Vector3 = Vector3(0,PI,0)
##valeur du vecteur de rotation du joueur lors d'un deplacement vers la diagonale avant droite
const ROTATION_DIAGONALE_AVANT_DROITE_VECTEUR : Vector3 = Vector3(0,-PI/4,0)
##valeur du vecteur de rotation du joueur lors d'un deplacement vers la diagonale avant gauche
const ROTATION_DIAGONALE_AVANT_GAUCHE_VECTEUR : Vector3 = Vector3(0,PI/4,0)
##valeur du vecteur de rotation du joueur lors d'un deplacement vers la diagonale arriere droite
const ROTATION_ARRIERE_DROITE_VECTEUR : Vector3 = Vector3(0,-3*PI/4,0)
##valeur du vecteur de rotation du joueur lors d'un deplacement vers la diagonale arriere gauche
const ROTATION_ARRIERE_GAUCHE_VECTEUR : Vector3 = Vector3(0,3*PI/4,0)
##valeur d'une rotation vers la droite
const FACTEUR_ROTATION_DROITE : float = -PI/2
##valeur d'une rotation vers la gauche
const FACTEUR_ROTATION_GAUCHE : float = PI/2
##valeur d'une rotation vers l'avant
const FACTEUR_ROTATION_AVANT : float = 2*PI
##valeur d'une rotation vers l'arriere
const FACTEUR_ROTATION_ARRIERE : float = PI
##valeur d'une rotation vers la diagonale avant droite
const FACTEUR_ROTATION_DIAGONALE_AVANT_DROITE : float = -PI/4
##valeur d'une rotation vers la diagonale avant gauche
const FACTEUR_ROTATION_DIAGONALE_AVANT_GAUCHE : float = PI/4
##valeur d'une rotation vers la diagonale arriere droite
const FACTEUR_ROTATION_DIAGONALE_ARRIERE_DROITE : float = -3*PI/4
##valeur d'une rotation vers la diagonale arriere gauche
const FACTEUR_ROTATION_DIAGONALE_ARRIERE_GAUCHE : float = 3*PI/4


#----------------------
#constantes d'animation
#----------------------
##nom de l'animation liee au saut
const ANIMATION_SAUT : String = "Jump"
##nom de l'animation liee a la marche
const ANIMATION_MARCHE : String = "Walk"
##nom de l'animation liee au idle
const ANIMATION_IDLE : String = "Dance"
##nom de l'animation liee a l'interaction
const ANIMATION_INTERACTION : String = "Interact"
##vitesse d'execution des animations en general
const VITESSE_ANIMATION_INITIALE : int = 1
##vitesse d'execution de l'animation liee a l'interaction
const VITESSE_ANIMATION_INTERACTION : float = 1.5
##vitesse d'execution de l'animation liee au saut
const VITESSE_ANIMATION_SAUT : float = 1.9


#------------------
#constantes de sons
#------------------
##effet sonore du saut du joueur
var SON_SAUT : AudioStream = load("res://sons/jump_8bits.mp3")


##signal lorsque quelque chose entre en contact avec le joueur
signal player_hit_
##signal lorsque le joueur appuie sur la touche d'interaction generale
signal interaction_joueur_


##permet au joueur de bouger si la valeur est vraie
var permissionMouvement : bool = true : set = setPermissionMouvement, get = getPermissionMouvement
##vrai lorsque le joueur a un objet dans ses mains
var objetDansMains : bool
##temporaire pour les connexions
var stfu


func _ready():
	chronometreEsquive.set_one_shot(true)


var interactionJoueur : InteractionJoueur = InteractionJoueur.new(self)
func _physics_process(delta):
	appliquerGravite(delta)
	
	if permissionMouvement:
		effectuerProcedureMouvementJoueur(delta)
		afficherInventaireJoueur()

	interactionJoueur.effectuerInteractionJoueur()


##Permet d'appliquer la gravite sur le personnage du joueur
func appliquerGravite(delta) -> void:
	if (velocity.y <= 0):
		velocity.y += GRAVITE_SOL_JOUEUR * delta
	else:
		velocity.y += GRAVITE_SAUT_JOUEUR * delta
	
	move_and_slide()

var entreeMouvementJoueur : EntreeMouvementJoueur = EntreeMouvementJoueur.new(self)
##permet de jouer le role de la methode main pour l'appel de fonctions
##liees au mouvement du joueur
func effectuerProcedureMouvementJoueur(delta):
	var facteursMouvementJoueur : FacteursMouvementJoueur = (entreeMouvementJoueur
																.saisirEntreeMouvementJoueur())

	effectuerProcedureAppplicationMouvement	(delta, facteursMouvementJoueur)


func effectuerProcedureAppplicationMouvement(delta, facteursMouvementJoueur : FacteursMouvementJoueur):
	#tourne le joueur face a la direction de son mouvement
	appliquerRotationJoueur(facteursMouvementJoueur.vecteurDirectionJoueurBrut)

	#application des animations en fonction de la direction du mouvement
	appliquerAnimationMouvement(facteursMouvementJoueur.vecteurDirectionJoueur)

	#application du mouvement
	appliquerMouvement(delta, facteursMouvementJoueur.vecteurDirectionJoueur,
	facteursMouvementJoueur.vitesseEsquiveJoueur)


##permet d'effectuer la rotation du joueur en fonction de la direction du mouvement horizontal
##c-a-d le joueur fera face a la direction de son mouvement
func appliquerRotationJoueur(directionJoueur : Vector3) -> void:
	#vecteur de la rotation appliquee au joueur
	var vecteurRotation : Vector3
	#vecteur de la rotation de la camera avant que la rotation soit appliquee
	var vecteurRotationInitialCamera

	#afin de pouvoir tourner en saut ou en tombant
	directionJoueur.y = 0
	#necessaire pour appliquer correctement la rotation
	directionJoueur.x = int(round(directionJoueur.x))
	directionJoueur.z = int(round(directionJoueur.z))

	#effectue la rotation en fonction de la direction du mouvement horizontal
	if directionJoueur != Vector3.ZERO:
		vecteurRotation = determinerVecteurRotation(directionJoueur)
		vecteurRotationInitialCamera = axeRotationCamera.get_global_rotation_degrees()
		#tourne le joueur
		rotation.y = lerp_angle(rotation.y, vecteurRotation.y, INTERPOLATION_ROTATION_JOUEUR)
		#conserve la rotation de la camera
		axeRotationCamera.conserverRotationCamera(vecteurRotationInitialCamera)

const DIRECTION_AVANT : int = 1
##permet de determiner quel vecteur de rotation sera utilise par
##la fonction appliquerRotationJoueur
func determinerVecteurRotation(directionJoueur : Vector3) -> Vector3:
	#vecteur de la rotation applique en fonction de la direction
	var vecteurRotation : Vector3 = Vector3.ZERO
	vecteurRotation.y = axeRotationCamera.get_global_rotation().y
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
		

##permet d'appliquer les animations liees au mouvement
func appliquerAnimationMouvement(vecteurDirectionJoueur : Vector3) -> void:
	#application de l'animation de saut
	if mouvementJoueurEstSaut(): 
		animationJoueur.appliquerAnimation(ANIMATION_SAUT)
		animationJoueur.ajusterVitesseAnimation(VITESSE_ANIMATION_SAUT)

	#application de l'animation de marche
	elif mouvementJoueurEstMarche(vecteurDirectionJoueur):
		animationJoueur.ajusterVitesseAnimation(VITESSE_ANIMATION_INITIALE)
		animationJoueur.appliquerAnimation(ANIMATION_MARCHE)

	#application de l'animation lorsqu'il n'y a aucun mouvement
	else:
		animationJoueur.ajusterVitesseAnimation(VITESSE_ANIMATION_INITIALE)
		animationJoueur.appliquerAnimation(ANIMATION_IDLE)

func mouvementJoueurEstSaut() -> bool:
	return !joueurEstAuSol() and animationJoueur.has_animation(ANIMATION_SAUT)


func mouvementJoueurEstMarche(vecteurDirectionJoueur) -> bool:
	return vecteurDirectionJoueur != Vector3.ZERO and animationJoueur.has_animation(ANIMATION_MARCHE)


##permet d'appliquer le mouvement au personnage du joueur
func appliquerMouvement(delta, directionJoueur, vitesseEsquiveJoueur) -> void:
	#application du saut
	if (joueurAvaitSaisiBouttonSaut(directionJoueur) and joueurEstAuSol()):
		appliquerSaut(delta)

	#application du mouvement horizontal sur l'axe x
	velocity.x = directionJoueur.x * vitesseJoueur * delta * vitesseEsquiveJoueur
	#application du mouvement horizontal sur l'axe z
	velocity.z = directionJoueur.z * vitesseJoueur * delta * vitesseEsquiveJoueur

	move_and_slide()


func joueurAvaitSaisiBouttonSaut(vecteurDirectionJoueur : Vector3) -> bool:
	return vecteurDirectionJoueur.y != 0


#permet d'appliquer le saut au personnage du joueur
func appliquerSaut(delta) -> void:
	#application du saut
	velocity.y = IMPULSION_SAUT_JOUEUR * delta

	#application de l'effet sonore associe au saut
	audioJoueur.appliquerSon(SON_SAUT)


##permet de deplacer le joueur vers un position donnee en parametre
func starting_position(pos) -> void:
	#application de la position de depart au joueur
	position = pos


##permet d'afficher une ligne suivant le joueur lors de l'esquive
func afficherLigneEsquive() -> void:
	$DashLine2D.show()
	$DashLine2D/DashLineTimer.start()


##permet d'evaluer si le joueur est au sol
func joueurEstAuSol() -> bool:
	return raycastJoueurSol.is_colliding()


##relancement du mouvement lorsque des animations demandant l'arret du mouvement sont terminees
func relancerMouvement() -> void:
	setPermissionMouvement(true)
	animationJoueur.ajusterVitesseAnimation(VITESSE_ANIMATION_INITIALE)

##permet d'arreter le mouvement du joueur
func arreterMouvement() -> void:
	setPermissionMouvement(false)
	velocity = Vector3.ZERO


##permet d'afficher l'inventaire du joueur conditionnellement
func afficherInventaireJoueur() -> void:
	if Input.is_action_just_pressed("inventaire_joueur"):
		if demanderAfficherInventaireJoueur():
			print("permission pour afficher l'inventaire!")
			$InventaireJoueur.montrerInterface()


##permet d'evaluer si le joueur peut afficher son inventaire
func demanderAfficherInventaireJoueur() -> bool:
	return evaluerAfficherInventaireJeu() and evaluerAfficherInventaireJoueur()


##permet d'evaluer si le joueur peut ouvrir son inventaire par rapport a
##l'etat actuel du jeu
func evaluerAfficherInventaireJoueur() -> bool:
	return joueurEstAuSol() and permissionMouvement


##permet d'evaluer si le joueur peut ouvrir son inventaire par rapport a
##l'etat actuel du joueur
func evaluerAfficherInventaireJeu() -> bool:
	return Input.is_action_just_pressed("inventaire_joueur") and !get_tree().paused


##emet le signal interaction_joueur_
func emettreSignalInteraction() -> void:
	emit_signal("interaction_joueur_")
	

func getPermissionMouvement() -> bool:
	return permissionMouvement


func setPermissionMouvement(nouvellePermission : bool) -> void:
	permissionMouvement = nouvellePermission

