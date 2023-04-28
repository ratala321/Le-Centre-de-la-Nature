extends CharacterBody3D

@export var vitesseJoueur = 14

@onready var chronometreEsquive = get_node("ChronometreEsquive")

##direction valeur en x et y du vecteur de direction
const DIRECTION_DROITE : int = -1
const DIRECTION_GAUCHE : int = 1
const DIRECTION_HAUT : int = 1
const DIRECTION_BAS : int = -1
##vitesse d'esquive initiale
const VITESSE_ESQUIVE_JOUEUR_INITIALE : int = 1
##force l'impulsion du saut du joueur
const IMPULSION_SAUT_JOUEUR : int = 20
##force gravitationnelle poussant le joueur vers le sol
const GRAVITE_JOUEUR : int = -IMPULSION_SAUT_JOUEUR / 8
##intervalle de temps entre deux esquives du joueur
const INTERVALLE_ESQUIVE_JOUEUR : int = 3

#-----------------------
#constantes de direction
#-----------------------
##valeur du vecteur correspodant a la direction droite
const DIRECTION_DROITE_VECTEUR : Vector3 = Vector3(-1, 0 ,0)
##valeur du vecteur correspodant a la direction gauche
const DIRECTION_GAUCHE_VECTEUR : Vector3 = Vector3(1, 0 ,0)
##valeur du vecteur correspodant a la direction avant
const DIRECTION_AVANT_VECTEUR : Vector3 = Vector3(0, 0 ,1)
##valeur du vecteur correspodant a la direction arriere
const DIRECTION_ARRIERE_VECTEUR : Vector3 = Vector3(0, 0 ,-1)
##valeur du vecteur correspodant a la direction diagonale avant et droite
const DIRECTION_DIAGONALE_AVANT_DROITE_VECTEUR : Vector3 = Vector3(-1, 0 ,1)
##valeur du vecteur correspodant a la direction diagonale avant et gauche
const DIRECTION_DIAGONALE_AVANT_GAUCHE_VECTEUR : Vector3 = Vector3(1, 0 ,1)
##valeur du vecteur correspodant a la direction diagonale arriere et droite
const DIRECTION_DIAGONALE_ARRIERE_DROITE_VECTEUR : Vector3 = Vector3(-1, 0 ,-1)
##valeur du vecteur correspodant a la direction diagonale arriere et gauche
const DIRECTION_DIAGONALE_ARRIERE_GAUCHE_VECTEUR : Vector3 = Vector3(1, 0 ,-1)

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


##signal lorsque quelque chose entre en contact avec le joueur
signal player_hit_
##signal lorsque le joueur esquive
signal esquive_
##signal lorsque le joueur appuie sur la touche d'interaction generale
signal interaction_joueur_


##raycast3D pointant vers le sol
var raycastJoueurSol : RayCast3D = RayCast3D.new()
#temporaire pour les connexions
var stfu


func _ready():
	chronometreEsquive.set_one_shot(true)
	raycastJoueurSol.target_position = Vector3(0,-2,0)


func _process(delta):
	mouvementJoueur(delta)

	appliquerGravite()

	emettreInteractionJoueur()


##Permet d'appliquer la gravite sur le personnage du joueur
func appliquerGravite() -> void:
	velocity.y = GRAVITE_JOUEUR
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
	
	#fonction qui saisie l'entree du mouvement du joueur
	vecteurDirectionJoueur = saisirEntreeMouvement()

	#tourne le joueur face a la direction de son mouvement
	appliquerRotationJoueur(vecteurDirectionJoueur)
	
	#fonction normalisant le mouvement diagonal
	vecteurDirectionJoueur = normaliserMouvementDiagonal(vecteurDirectionJoueur)

	#fonction qui saisie l'entree de l'esquive du joueur
	#vitesseEsquiveJoueur = saisirEntreeEsquive()
	
	#fonction appliquant les animations de mouvement
	appliquerAnimationMouvement()
	
	#fonction appliquant le mouvement
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
		directionHorizontaleJoueur.z = DIRECTION_HAUT 
	if Input.is_action_pressed("mouvement_bas"):
		directionHorizontaleJoueur.z = DIRECTION_BAS
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



##permet d'effectuer la rotation du joueur en fonction de la direction du mouvement
##c-a-d le joueur fera face a la direction de son mouvement
func appliquerRotationJoueur(directionJoueur : Vector3) -> void:
	if directionJoueur == DIRECTION_ARRIERE_VECTEUR:
		set_rotation(ROTATION_ARRIERE_VECTEUR)
	elif directionJoueur == DIRECTION_AVANT_VECTEUR:
		set_rotation(ROTATION_AVANT_VECTEUR)
	elif directionJoueur == DIRECTION_DROITE_VECTEUR:
		set_rotation(ROTATION_DROITE_VECTEUR)
	elif directionJoueur == DIRECTION_GAUCHE_VECTEUR:
		set_rotation(ROTATION_GAUCHE_VECTEUR)
	elif directionJoueur == DIRECTION_DIAGONALE_AVANT_DROITE_VECTEUR:
		set_rotation(ROTATION_DIAGONALE_AVANT_DROITE_VECTEUR)
	elif directionJoueur == DIRECTION_DIAGONALE_AVANT_GAUCHE_VECTEUR:
		set_rotation(ROTATION_DIAGONALE_AVANT_GAUCHE_VECTEUR)
	elif directionJoueur == DIRECTION_DIAGONALE_ARRIERE_DROITE_VECTEUR:
		set_rotation(ROTATION_ARRIERE_DROITE_VECTEUR)
	elif directionJoueur == DIRECTION_DIAGONALE_ARRIERE_GAUCHE_VECTEUR:
		set_rotation(ROTATION_ARRIERE_GAUCHE_VECTEUR)


##permet de saisir l'entree du joueur pour l'esquive
func saisirEntreeEsquive() -> int:
	var vitesseEsquiveJoueur = VITESSE_ESQUIVE_JOUEUR_INITIALE

	#saisie de l'input pour l'esquive
	if Input.is_action_just_pressed("esquive") && chronometreEsquive.is_stopped():
		#fonction reinitialisant le chronometre d'esquive et emettant le signal esquive
		relancerChronoEsquive()
		#fonction affichant la ligne d'esquive se trouvant derriere le joueur
		afficherLigneEsquive()

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
		appliquerSaut()

	#reinitialiser la valeur y du vecteurDirectionJoueur
	directionJoueur.y = 0

	#application du mouvement horizontal
	position += directionJoueur * vitesseJoueur * delta * vitesseEsquiveJoueur


#permet d'appliquer le saut au personnage du joueur
func appliquerSaut() -> void:
	#methode avec force physique
	velocity.y = IMPULSION_SAUT_JOUEUR
	move_and_slide()
	pass


##permet d'appliquer les animations liees au mouvement
func appliquerAnimationMouvement() -> void:
	#application des animations
	#appliquer en fonction de la direction du vecteurDirectionJoueur
	pass


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
	print(raycastJoueurSol.is_colliding())
	raycastJoueurSol.enabled = true
	raycastJoueurSol.force_raycast_update()
	return raycastJoueurSol.is_colliding()

#################################
#FIN FONCTIONS LIEES AU MOUVEMENT
#################################


##########################
#INTERACTION PAR LE JOUEUR
##########################

##emet le signal [signal interaction_joueur_] lorsque le joueur appuie sur la touche
##correspondant a l'action [b]interaction_joueur[/b]
func emettreInteractionJoueur() -> void:
	if Input.is_action_pressed("interaction_joueur"):
		emit_signal("interaction_joueur_")

##############################
#FIN INTERACTION PAR LE JOUEUR
##############################
