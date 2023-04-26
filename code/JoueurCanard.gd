extends CharacterBody3D

@export var vitesseJoueur = 14

##constante direction valeur en x et y du vecteur de direction
const DIRECTION_DROITE : int = -1
const DIRECTION_GAUCHE : int = 1
const DIRECTION_HAUT : int = 1
const DIRECTION_BAS : int = -1
##constante de la vitesse d'esquive initiale
const VITESSE_ESQUIVE_JOUEUR_INITIALE : int = 1
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
##signal lorsque le joueur dash
signal esquive_
##signal lorsque le joueur appuie sur la touche d'interaction generale
signal interaction_joueur_


#temporaire pour les connexions
var stfu


func _process(delta):
	mouvementJoueur(delta)


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
	#determine si le joueur sautera
	var permissionSautJoueur : bool = false
	
	#fonction qui saisie l'entree du mouvement du joueur
	vecteurDirectionJoueur = entreeMouvement()

	#fonction qui determine si le joueur a la permission de sauter
	permissionSautJoueur = evaluationSautJoueur(vecteurDirectionJoueur)

	#reinitialiser la valeur y du vecteurDirectionJoueur si vecteur n'est pas un objet?

	print("direction y du vecteur direction joueur : " + str(vecteurDirectionJoueur.y))

	#tourne le joueur face a la direction de son mouvement
	rotationJoueur(vecteurDirectionJoueur)
	
	#fonction normalisant le mouvement diagonal
	vecteurDirectionJoueur = normalisationMouvementDiagonal(vecteurDirectionJoueur)

	#fonction qui saisie l'entree de l'esquive du joueur
	#vitesseEsquiveJoueur = entreeEsquive()
	
	#fonction appliquant les animations de mouvement
	applicationAnimationMouvement()
	
	#fonction appliquant le mouvement
	applicationMouvement(delta, vecteurDirectionJoueur, vitesseEsquiveJoueur)

##permet de saisir l'entree du joueur pour le mouvement
func entreeMouvement() -> Vector3:
	var directionJoueur = Vector3.ZERO

	directionJoueur = entreeMouvementHorizontal()

	directionJoueur.y = entreeMouvementVertical()
	
	return directionJoueur


##permet de saisir l'entree du joueur pour le mouvement horizontal
func entreeMouvementHorizontal() -> Vector3:
	var directionHorizontaleJoueur = Vector3.ZERO

	#bloc de saisie d'input pour la direction du mouvement
	if Input.is_action_pressed("mouvement_haut"):
		directionJoueur.z = DIRECTION_HAUT 
	if Input.is_action_pressed("mouvement_bas"):
		directionJoueur.z = DIRECTION_BAS
	if Input.is_action_pressed("mouvement_droite"):
		directionJoueur.x = DIRECTION_DROITE
	if Input.is_action_pressed("mouvement_gauche"):
		directionJoueur.x = DIRECTION_GAUCHE
	
	return directionHorizontaleJoueur


##permet de saisir l'entree du joueur pour le mouvement vertical
##
##[b]notes sur l'implementation[/b] : renvoie un int destine a etre place en
##y dans la vecteur de la direction du mouvement
func entreeMouvementVertical() -> Vector3:
	var directionVerticaleJoueur : int = 0

	#bloc de saisie d'input pour la direction du mouvement
	if Input.is_action_pressed("saut"):
		directionVerticaleJoueur = 1
	
	return directionVerticaleJoueur


##? test pour voir si le vecteur est un objet
func evaluationSautJoueur(vecteurDirectionJoueur : Vector3) -> bool:
	#vrai si le joueur a la permission de sauter
	var permissionSautJoueur : bool = false

	#bloc evaluant si le joueur a la permission de sauter
	if (vecteurDirectionJoueur.y == 1):
		vecteurDirectionJoueur.y = 0
		permissionSautJoueur = true
	
	return permissionSautJoueur



##permet d'effectuer la rotation du joueur en fonction de la direction du mouvement
##c-a-d le joueur fera face a la direction de son mouvement
func rotationJoueur(directionJoueur : Vector3) -> void:
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
func entreeEsquive() -> int:
	var vitesseEsquiveJoueur = VITESSE_ESQUIVE_JOUEUR_INITIALE

	#saisie de l'input pour le dash
	if Input.is_action_just_pressed("dash") && $DashTimer.is_stopped():
		#fonction reinitialisant le chronometre d'esquive et emettant le signal esquive
		relanceChronoEsquive()
		#fonction affichant la ligne d'esquive se trouvant derriere le joueur
		affichageLigneEsquive()

	return vitesseEsquiveJoueur
		

##permet de faire en sorte que le mouvement diagonal soit equivalent
##aux autres mouvements en terme de vitesse
func normalisationMouvementDiagonal(directionJoueur) -> Vector3:
	#normalisation du mouvement diagonal
	if directionJoueur != Vector3.ZERO:
		directionJoueur = directionJoueur.normalized()

	return directionJoueur


##permet d'appliquer le mouvement au personnage du joueur
func applicationMouvement(delta, directionJoueur, vitesseEsquiveJoueur) -> void:
	#application du mouvement
	position += directionJoueur * vitesseJoueur * delta * vitesseEsquiveJoueur


##permet d'appliquer les animations liees au mouvement
func applicationAnimationMouvement() -> void:
	#application des animations
	#appliquer en fonction de la direction du vecteurDirectionJoueur
	pass


##permet de deplacer le joueur vers un position donnee en parametre
func starting_position(pos) -> void:
	#application de la position de depart au joueur
	position = pos


##permet d'afficher une ligne suivant le joueur lors de l'esquive
func affichageLigneEsquive() -> void:
	$DashLine2D.show()
	$DashLine2D/DashLineTimer.start()


##permet de relancer le chronometre limitant le nombre d'esquive
func relanceChronoEsquive() -> void:
	$DashTimer.start()
	emit_signal("esquive_")

#################################
#FIN FONCTIONS LIEES AU MOUVEMENT
#################################


##########################
#INTERACTION PAR LE JOUEUR
##########################

##emet le signal [signal interaction_joueur_] lorsque le joueur appuie sur la touche
##correspondant a l'action [b]interaction_joueur[/b]
func interactionJoueur() -> void:
	if Input.is_action_pressed("interaction_joueur"):
		emit_signal("interaction_joueur_")

##############################
#FIN INTERACTION PAR LE JOUEUR
##############################
