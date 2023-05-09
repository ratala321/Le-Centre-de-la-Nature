extends CharacterBody3D
class_name JoueurCanard

@export var vitesseJoueur = 450

##contient la reference au node de Timer nommee ChronometreEsquive du joueur
@onready var chronometreEsquive = get_node("ChronometreEsquive")
##contient la reference au node de RayCast3D nommee RayEstAuSol du joueur
@onready var raycastJoueurSol = get_node("RayEstAuSol")
##contient la reference au node d'AnimationPlayer du joueur
@onready var animationPlayerJoueur = get_node("KayKit_AnimatedCharacter_v13/AnimationPlayer")
##contient la reference au node d'AudioStreamPlayer du joueur
@onready var audioStreamJoueur = get_node("AudioStreamPlayer")
##contient la reference au node d'AxeRotationCamera du joueur
@onready var axeRotationCamera = get_node("AxeRotationCamera")

##direction valeur en x et y du vecteur de direction
const DIRECTION_DROITE : int = -1
const DIRECTION_GAUCHE : int = 1
const DIRECTION_AVANT : int = 1
const DIRECTION_ARRIERE : int = -1
##vitesse d'esquive initiale
const VITESSE_ESQUIVE_JOUEUR_INITIALE : int = 1
##vitesse d'esquive lors de l'entree utilisateur
const VITESSE_ESQUIVE_JOUEUR_FINALE : int = 50
##force gravitationnelle lorsque le joueur est au sol
const GRAVITE_SOL_JOUEUR : int = -100


#------------------------
#constantes liees au saut
#------------------------
##determine la hauteur maximale du joueur lors d'un saut
const HAUTEUR_MAXIMALE_SAUT : int = 5000
##?inversee pour quelconque raison : plus c'est petit, plus c'est long?ajustement necessaire
const TEMPS_HAUTEUR_MAXIMALE_SAUT : int = 7
##?pas encore utilisee
const TEMPS_DESCENTE_SAUT : int = 2
##force gravitationnelle lorsque le joueur est en saut et se dirige vers le haut
const GRAVITE_SAUT_JOUEUR : int = -60
##force l'impulsion du saut du joueur
const IMPULSION_SAUT_JOUEUR : int = 2 * HAUTEUR_MAXIMALE_SAUT / TEMPS_HAUTEUR_MAXIMALE_SAUT


##intervalle de temps entre deux esquives du joueur
const INTERVALLE_ESQUIVE_JOUEUR : int = 3


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
##signal lorsque le joueur esquive
signal esquive_
##signal lorsque le joueur appuie sur la touche d'interaction generale
signal interaction_joueur_


##permet au joueur de bouger si la valeur est vraie
var permissionMouvement : bool = true : set = setPermissionMouvement, get = getPermissionMouvement
##temporaire pour les connexions
var stfu


func _ready():
	chronometreEsquive.set_one_shot(true)


func _physics_process(delta):
	appliquerGravite(delta)
	
	if permissionMouvement:
		mouvementJoueur(delta)

	effectuerInteractionJoueur()


##Permet d'appliquer la gravite sur le personnage du joueur
func appliquerGravite(delta) -> void:
	if (velocity.y <= 0):
		velocity.y += GRAVITE_SOL_JOUEUR * delta
	else:
		velocity.y += GRAVITE_SAUT_JOUEUR * delta
	
	move_and_slide()


#############################
#FONCTIONS LIEES AU MOUVEMENT
#############################

##permet de jouer le role de la methode main pour l'appel de fonctions
##liees au mouvement du joueur
func mouvementJoueur(delta):
	#vecteur de la direction du mouvement du joueur (declaration)
	var vecteurDirectionJoueur = Vector3.ZERO
	#reinitialisation du vecteur lie a la direction du mouvement
	var vitesseEsquiveJoueur = VITESSE_ESQUIVE_JOUEUR_INITIALE
	
	#saisie de l'entree du mouvement du joueur
	vecteurDirectionJoueur = saisirEntreeMouvement()

	#normalisation du mouvement diagonal
	vecteurDirectionJoueur = normaliserMouvementDiagonal(vecteurDirectionJoueur)

	#saisie l'entree de l'esquive du joueur
	vitesseEsquiveJoueur = saisirEntreeEsquive()

	#tourne le joueur face a la direction de son mouvement
	appliquerRotationJoueur(vecteurDirectionJoueur)

	#application des animations en fonction de la direction du mouvement
	appliquerAnimationMouvement(vecteurDirectionJoueur)

	#application du mouvement
	appliquerMouvement(delta, vecteurDirectionJoueur, vitesseEsquiveJoueur)


##permet de saisir l'entree du joueur pour le mouvement
func saisirEntreeMouvement() -> Vector3:
	var directionJoueur = Vector3.ZERO

	directionJoueur = saisirEntreeMouvementHorizontal()

	directionJoueur.y = saisirEntreeMouvementVertical()
	
	return directionJoueur


##permet de saisir l'entree du joueur pour le mouvement horizontal
func saisirEntreeMouvementHorizontal() -> Vector3:
	var directionHorizontaleJoueur = Vector3.ZERO

	#bloc de saisie d'input pour la direction du mouvement
	if Input.is_action_pressed("mouvement_haut"):
		directionHorizontaleJoueur.z = DIRECTION_AVANT 
	if Input.is_action_pressed("mouvement_bas"):
		directionHorizontaleJoueur.z = DIRECTION_ARRIERE
	if Input.is_action_pressed("mouvement_droite"):
		directionHorizontaleJoueur.x = DIRECTION_DROITE
	if Input.is_action_pressed("mouvement_gauche"):
		directionHorizontaleJoueur.x = DIRECTION_GAUCHE
	
	return directionHorizontaleJoueur


##permet de saisir l'entree du joueur pour le mouvement vertical
##
##[b]notes sur l'implementation[/b] : renvoie un int destine a etre place en
##y dans la vecteur de la direction du mouvement
func saisirEntreeMouvementVertical() -> int:
	var directionVerticaleJoueur : int = 0

	#saisie de l'input correspondant au saut du joueur
	if Input.is_action_pressed("saut"):
		directionVerticaleJoueur = 1
	
	return directionVerticaleJoueur


##permet de determiner si le joueur a saisie une touche pour le saut
##
##[b]notes sur l'implementation[/b] : lorsque le joueur saisie la touche de saut,
##la valeur en y du vecteurDirectionJoueur n'est pas egale a 0
func evaluerSaisieSautJoueur(vecteurDirectionJoueur : Vector3) -> bool:
	
	return vecteurDirectionJoueur.y != 0



##permet d'effectuer la rotation du joueur en fonction de la direction du mouvement horizontal
##c-a-d le joueur fera face a la direction de son mouvement
func appliquerRotationJoueur(directionJoueur : Vector3) -> void:
	#vecteur de la rotation appliquee au joueur
	var vecteurRotation : Vector3

	#initialisation de la valeur y de la direction joueur a 0 afin de pouvoir tourner en saut ou en tombant
	directionJoueur.y = 0
	#arondissement des valeurs x et z de la direction vers 1
	directionJoueur.x = int(round(directionJoueur.x))
	directionJoueur.z = int(round(directionJoueur.z))

	#effectue la rotation en fonction de la direction du mouvement horizontal
	if directionJoueur != Vector3.ZERO:
		vecteurRotation = determinerVecteurRotation(directionJoueur)
		set_rotation(vecteurRotation)
		#?
		axeRotationCamera.tournerCameraMouvementJoueur(vecteurRotation)


##permet de determiner quel vecteur de rotation sera utilise par
##la fonction appliquerRotationJoueur
func determinerVecteurRotation(directionJoueur : Vector3) -> Vector3:
	#vecteur de la rotation applique en fonction de la direction
	var vecteurRotation : Vector3

	if directionJoueur == DIRECTION_ARRIERE_VECTEUR:
		vecteurRotation = ROTATION_ARRIERE_VECTEUR
	elif directionJoueur == DIRECTION_AVANT_VECTEUR:
		vecteurRotation = ROTATION_AVANT_VECTEUR
	elif directionJoueur == DIRECTION_DROITE_VECTEUR:
		vecteurRotation = ROTATION_DROITE_VECTEUR
	elif directionJoueur == DIRECTION_GAUCHE_VECTEUR:
		vecteurRotation = ROTATION_GAUCHE_VECTEUR
	elif directionJoueur == DIRECTION_DIAGONALE_AVANT_DROITE_VECTEUR:
		vecteurRotation = ROTATION_DIAGONALE_AVANT_DROITE_VECTEUR
	elif directionJoueur == DIRECTION_DIAGONALE_AVANT_GAUCHE_VECTEUR:
		vecteurRotation = ROTATION_DIAGONALE_AVANT_GAUCHE_VECTEUR
	elif directionJoueur == DIRECTION_DIAGONALE_ARRIERE_DROITE_VECTEUR:
		vecteurRotation = ROTATION_ARRIERE_DROITE_VECTEUR
	elif directionJoueur == DIRECTION_DIAGONALE_ARRIERE_GAUCHE_VECTEUR:
		vecteurRotation = ROTATION_ARRIERE_GAUCHE_VECTEUR
	
	return vecteurRotation


##permet de saisir l'entree du joueur pour l'esquive
func saisirEntreeEsquive() -> int:
	var vitesseEsquiveJoueur = VITESSE_ESQUIVE_JOUEUR_INITIALE

	#saisie de l'input pour l'esquive
	if Input.is_action_just_pressed("esquive") && chronometreEsquive.is_stopped():
		#fonction reinitialisant le chronometre d'esquive et emettant le signal esquive
		relancerChronoEsquive()
		vitesseEsquiveJoueur = VITESSE_ESQUIVE_JOUEUR_FINALE
		print("le joueur esquive")
		#fonction affichant la ligne d'esquive se trouvant derriere le joueur
		#afficherLigneEsquive()

	return vitesseEsquiveJoueur
		

##permet de faire en sorte que le mouvement diagonal soit equivalent
##aux autres mouvements en terme de vitesse
func normaliserMouvementDiagonal(directionJoueur) -> Vector3:
	#normalisation du mouvement diagonal
	if directionJoueur != Vector3.ZERO:
		directionJoueur = directionJoueur.normalized()

	return directionJoueur


##permet d'appliquer le mouvement au personnage du joueur
func appliquerMouvement(delta, directionJoueur, vitesseEsquiveJoueur) -> void:
	#application du saut
	if (evaluerSaisieSautJoueur(directionJoueur) and evaluerJoueurAuSol()):
		appliquerSaut(delta)

	#application du mouvement horizontal sur l'axe x
	velocity.x = directionJoueur.x * vitesseJoueur * delta * vitesseEsquiveJoueur
	#application du mouvement horizontal sur l'axe z
	velocity.z = directionJoueur.z * vitesseJoueur * delta * vitesseEsquiveJoueur
	move_and_slide()


#permet d'appliquer le saut au personnage du joueur
func appliquerSaut(delta) -> void:
	#application du saut
	velocity.y = IMPULSION_SAUT_JOUEUR * delta

	#application de l'effet sonore associe au saut
	appliquerSon(SON_SAUT)


##permet d'appliquer les animations liees au mouvement
func appliquerAnimationMouvement(vecteurDirectionJoueur : Vector3) -> void:
	#application de l'animation de saut
	if !evaluerJoueurAuSol() and animationPlayerJoueur.has_animation(ANIMATION_SAUT):
		appliquerAnimation(ANIMATION_SAUT)
		ajusterVitesseAnimation(VITESSE_ANIMATION_SAUT)

	#application de l'animation de marche
	elif vecteurDirectionJoueur != Vector3.ZERO and animationPlayerJoueur.has_animation(ANIMATION_MARCHE):
		ajusterVitesseAnimation(VITESSE_ANIMATION_INITIALE)
		appliquerAnimation(ANIMATION_MARCHE)

	#application de l'animation lorsqu'il n'y a aucun mouvement
	else:
		ajusterVitesseAnimation(VITESSE_ANIMATION_INITIALE)
		appliquerAnimation(ANIMATION_IDLE)


##permet de deplacer le joueur vers un position donnee en parametre
func starting_position(pos) -> void:
	#application de la position de depart au joueur
	position = pos


##permet d'afficher une ligne suivant le joueur lors de l'esquive
func afficherLigneEsquive() -> void:
	$DashLine2D.show()
	$DashLine2D/DashLineTimer.start()


##permet de relancer le chronometre limitant le nombre d'esquive
func relancerChronoEsquive() -> void:
	chronometreEsquive.start(INTERVALLE_ESQUIVE_JOUEUR)
	emit_signal("esquive_")

##permet d'evaluer si le joueur est au sol
func evaluerJoueurAuSol() -> bool:
	return raycastJoueurSol.is_colliding()


##relancement du mouvement lorsque des animations demandant l'arret du mouvement sont terminees
func relancerMouvement() -> void:
	setPermissionMouvement(true)
	ajusterVitesseAnimation(VITESSE_ANIMATION_INITIALE)

##permet d'arreter le mouvement du joueur
func arreterMouvement() -> void:
	setPermissionMouvement(false)
	velocity = Vector3.ZERO

#################################
#FIN FONCTIONS LIEES AU MOUVEMENT
#################################


##########################
#INTERACTION PAR LE JOUEUR
##########################

##emet le signal [signal interaction_joueur_] lorsque le joueur appuie sur la touche
##correspondant a l'action [b]interaction_joueur[/b]
func effectuerInteractionJoueur() -> void:
	if evaluerJoueurAuSol() and Input.is_action_pressed("interaction_joueur"):
		emit_signal("interaction_joueur_")

		#application de l'animation liee a l'interaction du joueur
		ajusterVitesseAnimation(VITESSE_ANIMATION_INTERACTION)
		appliquerAnimation(ANIMATION_INTERACTION)

##############################
#FIN INTERACTION PAR LE JOUEUR
##############################

#######################
#FONCTIONS LIEES AU SON
#######################

##permet de jouer un effet sonore specifie en parametre
func appliquerSon(son) -> void:
	audioStreamJoueur.stream = son
	audioStreamJoueur.play()

###########################
#FIN FONCTIONS LIEES AU SON
###########################

##############################
#FONCTIONS LIEES A L'ANIMATION
##############################

##permet d'appliquer une animation passee en parametre
func appliquerAnimation(animation : String) -> void:
	animationPlayerJoueur.play(animation)


##permet d'ajuster la vitesse d'excution des animations liees au joueur
func ajusterVitesseAnimation(vitesse) -> void:
	animationPlayerJoueur.speed_scale = vitesse

##################################
#FIN FONCTIONS LIEES A L'ANIMATION
##################################

###################
#ACCESSEURS GETTERS
###################

func getPermissionMouvement() -> bool:
	return permissionMouvement

#######################
#FIN ACCESSEURS GETTERS
#######################

######################
#MODIFICATEURS SETTERS
######################

func setPermissionMouvement(nouvellePermission : bool) -> void:
	permissionMouvement = nouvellePermission

##########################
#FIN MODIFICATEURS SETTERS
##########################
