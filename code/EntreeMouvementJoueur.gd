extends Node

func saisirEntreeMouvementJoueur() -> FacteursMouvementJoueur:
	#vecteur de la direction du mouvement du joueur sans modifications	
	var vecteurDirectionJoueurBrut : Vector3 = _saisirEntreeDirectionJoueur()	
	#vecteur de la direction du mouvement destine a etre utilise pour le mouvement
	var vitesseEsquiveJoueur : int = _saisirEntreeEsquive()
	#reinitialisation du vecteur lie a la direction du mouvement
	var vecteurDirectionJoueur = _effectuerProcedureAjustementDirectionJoueur(vecteurDirectionJoueurBrut)

	var facteurs : FacteursMouvementJoueur = _assemblerElementsMouvementJoueur(vecteurDirectionJoueurBrut,
	vitesseEsquiveJoueur, vecteurDirectionJoueur)

	return facteurs


##permet de saisir l'entree du joueur pour le mouvement
func _saisirEntreeDirectionJoueur() -> Vector3:
	var directionJoueur = Vector3.ZERO

	directionJoueur = _saisirEntreeDirectionJoueurHorizontal()

	directionJoueur.y = _saisirEntreeDirectionJoueurVertical()
	
	return directionJoueur


##direction valeur en x et y du vecteur de direction
const DIRECTION_DROITE : int = -1
const DIRECTION_GAUCHE : int = 1
const DIRECTION_AVANT : int = 1
const DIRECTION_ARRIERE : int = -1
##permet de saisir l'entree du joueur pour le mouvement horizontal
func _saisirEntreeDirectionJoueurHorizontal() -> Vector3:
	var directionHorizontaleJoueur = Vector3.ZERO

	#bloc de saisie d'input pour la direction du mouvement
	if Input.is_action_pressed("mouvement_avant"):
		directionHorizontaleJoueur.z = DIRECTION_AVANT 
	if Input.is_action_pressed("mouvement_arriere"):
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
func _saisirEntreeDirectionJoueurVertical() -> int:
	var directionVerticaleJoueur : int = 0

	#saisie de l'input correspondant au saut du joueur
	if Input.is_action_pressed("saut"):
		directionVerticaleJoueur = 1
	
	return directionVerticaleJoueur


##contient la reference au node de Timer nommee ChronometreEsquive du joueur
@onready var chronometreEsquive = get_node("ChronometreEsquive")
##vitesse d'esquive initiale
const VITESSE_ESQUIVE_JOUEUR_INITIALE : int = 1
##vitesse d'esquive lors de l'entree utilisateur
const VITESSE_ESQUIVE_JOUEUR_FINALE : int = 50
##permet de saisir l'entree du joueur pour l'esquive
func _saisirEntreeEsquive() -> int:
	var vitesseEsquiveJoueur = VITESSE_ESQUIVE_JOUEUR_INITIALE

	#saisie de l'input pour l'esquive
	if Input.is_action_just_pressed("esquive") && chronometreEsquive.is_stopped():
		#fonction reinitialisant le chronometre d'esquive et emettant le signal esquive
		_relancerChronoEsquive()
		vitesseEsquiveJoueur = VITESSE_ESQUIVE_JOUEUR_FINALE
		print("le joueur esquive")
		#fonction affichant la ligne d'esquive se trouvant derriere le joueur
		#afficherLigneEsquive()

	return vitesseEsquiveJoueur


##intervalle de temps entre deux esquives du joueur
const INTERVALLE_ESQUIVE_JOUEUR : int = 3
##permet de relancer le chronometre limitant le nombre d'esquive
func _relancerChronoEsquive() -> void:
	chronometreEsquive.start(INTERVALLE_ESQUIVE_JOUEUR)
	emit_signal("esquive_")


func _effectuerProcedureAjustementDirectionJoueur(vecteurDirectionJoueurBrut):
	var vecteurDirectionJoueur = Vector3.ZERO

	vecteurDirectionJoueur = _ajusterDirectionAvantEnFonctionCamera(vecteurDirectionJoueurBrut)

	vecteurDirectionJoueur = _normaliserMouvementDiagonal(vecteurDirectionJoueur)

	return vecteurDirectionJoueur


##permet d'ajuster la rotation de la direction du joueur en fonction
##de l'endroit ou la camera fait face
func _ajusterDirectionAvantEnFonctionCamera(directionJoueur) -> Vector3:
	#contient la direction vers laquelle la camera pointe
	var directionAvant : Vector3 = _determinerDirectionAvantMouvement()

	return directionJoueur.rotated(Vector3(0,1,0), directionAvant.y)


##contient la reference au node d'AxeRotationCamera du joueur
@onready var axeRotationCamera = get_node("AxeRotationCamera")
##permet de determiner la direction du mouvement vers l'avant en fonction
##de la direction de la camera.
func _determinerDirectionAvantMouvement() -> Vector3:
	return axeRotationCamera.get_global_rotation()


##permet de faire en sorte que le mouvement diagonal soit equivalent
##aux autres mouvements en terme de vitesse
func _normaliserMouvementDiagonal(directionJoueur) -> Vector3:
	#normalisation du mouvement diagonal
	if directionJoueur != Vector3.ZERO:
		directionJoueur = directionJoueur.normalized()

	return directionJoueur


func _assemblerElementsMouvementJoueur(vecteurDirectionJoueurBrut : Vector3,
vitesseEsquiveJoueur : int, vecteurDirectionJoueur : Vector3) -> FacteursMouvementJoueur:
	return FacteursMouvementJoueur.new(vecteurDirectionJoueurBrut,
				vitesseEsquiveJoueur, vecteurDirectionJoueur)
