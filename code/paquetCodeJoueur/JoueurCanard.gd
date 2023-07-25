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

##signal lorsque quelque chose entre en contact avec le joueur
signal player_hit_
##signal lorsque le joueur appuie sur la touche d'interaction generale
signal interaction_joueur_

##permet au joueur de bouger si la valeur est vraie
var permissionMouvement : bool = true : set = setPermissionMouvement, get = getPermissionMouvement
##vrai lorsque le joueur a un objet dans ses mains
var objetDansMains : bool


func _ready():
	chronometreEsquive.set_one_shot(true)


var interactionJoueur : InteractionJoueur = InteractionJoueur.new(self)
var affichageInventaireJoueur : AffichageInventaireJoueur = AffichageInventaireJoueur.new(self)
func _physics_process(delta):
	appliquerGravite(delta)
	
	if permissionMouvement:
		effectuerProcedureMouvementJoueur(delta)
		affichageInventaireJoueur.afficherInventaireJoueur()

	interactionJoueur.effectuerInteractionJoueur()


##force gravitationnelle lorsque le joueur est au sol
const GRAVITE_SOL_JOUEUR : int = -100
##force gravitationnelle lorsque le joueur est en saut et se dirige vers le haut
const GRAVITE_SAUT_JOUEUR : int = -60
##Permet d'appliquer la gravite sur le personnage du joueur
func appliquerGravite(delta) -> void:
	if (velocity.y <= 0):
		velocity.y += GRAVITE_SOL_JOUEUR * delta
	else:
		velocity.y += GRAVITE_SAUT_JOUEUR * delta
	
	move_and_slide()


var entreeMouvementJoueur : EntreeMouvementJoueur = EntreeMouvementJoueur.new(self)
var mouvementJoueur : MouvementJoueur = MouvementJoueur.new(self)
##permet de jouer le role de la methode main pour l'appel de fonctions
##liees au mouvement du joueur
func effectuerProcedureMouvementJoueur(delta):
	var facteursMouvementJoueur : FacteursMouvementJoueur = (entreeMouvementJoueur
																.saisirEntreeMouvementJoueur())

	mouvementJoueur.effectuerProcedureAppplicationMouvement(delta, facteursMouvementJoueur)


##permet d'evaluer si le joueur est au sol
func joueurEstAuSol() -> bool:
	return raycastJoueurSol.is_colliding()


##vitesse d'execution des animations en general
const VITESSE_ANIMATION_INITIALE : int = 1
##relancement du mouvement lorsque des animations demandant l'arret du mouvement sont terminees
func relancerMouvement() -> void:
	setPermissionMouvement(true)
	animationJoueur.ajusterVitesseAnimation(VITESSE_ANIMATION_INITIALE)

##permet d'arreter le mouvement du joueur
func arreterMouvement() -> void:
	setPermissionMouvement(false)
	velocity = Vector3.ZERO


##emet le signal interaction_joueur_
func emettreSignalInteraction() -> void:
	emit_signal("interaction_joueur_")
	

func getPermissionMouvement() -> bool:
	return permissionMouvement


func setPermissionMouvement(nouvellePermission : bool) -> void:
	permissionMouvement = nouvellePermission

