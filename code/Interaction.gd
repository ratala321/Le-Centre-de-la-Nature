extends Node

@onready var raycastJoueurSol = get_node("../RayEstAuSol")
@onready var animationJoueur = get_node("../KayKit_AnimatedCharacter_v13/AnimationPlayer")
@onready var mouvementJoueur = get_parent()

##vitesse d'execution de l'animation liee a l'interaction
const VITESSE_ANIMATION_INTERACTION : float = 1.5
##nom de l'animation liee a l'interaction
const ANIMATION_INTERACTION : String = "Interact"

##signal lorsque le joueur appuie sur la touche d'interaction generale
signal interaction_joueur_


##emet le signal [signal interaction_joueur_] lorsque le joueur appuie sur la touche
##correspondant a l'action [b]interaction_joueur[/b]
func effectuerInteractionJoueur() -> void:
	if joueurEstAuSol() and Input.is_action_just_pressed("interaction_joueur"):
		#application de l'animation liee a l'interaction du joueur
		animationJoueur.ajusterVitesseAnimation(VITESSE_ANIMATION_INTERACTION)
		animationJoueur.appliquerAnimation(ANIMATION_INTERACTION)

##emet le signal interaction_joueur_
func emettreSignalInteraction() -> void:
	emit_signal("interaction_joueur_")


##permet d'afficher l'inventaire du joueur conditionnellement
func afficherInventaireJoueur() -> void:
	if Input.is_action_just_pressed("inventaire_joueur"):
		if demanderAfficherInventaireJoueur():
			print("permission pour afficher l'inventaire!")
			get_node("../InventaireJoueur").montrerInterface()


##permet d'evaluer si le joueur peut afficher son inventaire
func demanderAfficherInventaireJoueur() -> bool:
	return evaluerAfficherInventaireJeu() and evaluerAfficherInventaireJoueur()


##permet d'evaluer si le joueur peut ouvrir son inventaire par rapport a
##l'etat actuel du jeu
func evaluerAfficherInventaireJoueur() -> bool:
	return joueurEstAuSol() and mouvementJoueur.permissionMouvement


##permet d'evaluer si le joueur est au sol
func joueurEstAuSol() -> bool:
	return raycastJoueurSol.is_colliding()


##permet d'evaluer si le joueur peut ouvrir son inventaire par rapport a
##l'etat actuel du joueur
func evaluerAfficherInventaireJeu() -> bool:
	return Input.is_action_just_pressed("inventaire_joueur") and !get_tree().paused
