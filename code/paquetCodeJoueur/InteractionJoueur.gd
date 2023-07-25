class_name InteractionJoueur extends Node

##vitesse d'execution de l'animation liee a l'interaction
const VITESSE_ANIMATION_INTERACTION : float = 1.5
##nom de l'animation liee a l'interaction
const ANIMATION_INTERACTION : String = "Interact"


var joueur : JoueurCanard
func _init(joueur : JoueurCanard):
	self.joueur = joueur

##emet le signal [signal interaction_joueur_] lorsque le joueur appuie sur la touche
##correspondant a l'action [b]interaction_joueur[/b]
func effectuerInteractionJoueur() -> void:
	if _joueurEstAuSol() and Input.is_action_just_pressed("interaction_joueur"):
		#application de l'animation liee a l'interaction du joueur
		joueur.animationJoueur.ajusterVitesseAnimation(VITESSE_ANIMATION_INTERACTION)
		joueur.animationJoueur.appliquerAnimation(ANIMATION_INTERACTION)


##permet d'afficher l'inventaire du joueur conditionnellement
func _afficherInventaireJoueur() -> void:
	if Input.is_action_just_pressed("inventaire_joueur"):
		if _demanderAfficherInventaireJoueur():
			print("permission pour afficher l'inventaire!")
			get_node("../InventaireJoueur").montrerInterface()


##permet d'evaluer si le joueur peut afficher son inventaire
func _demanderAfficherInventaireJoueur() -> bool:
	return _evaluerAfficherInventaireJeu() and _evaluerAfficherInventaireJoueur()


##permet d'evaluer si le joueur peut ouvrir son inventaire par rapport a
##l'etat actuel du jeu
func _evaluerAfficherInventaireJoueur() -> bool:
	return _joueurEstAuSol() and joueur.permissionMouvement


##permet d'evaluer si le joueur est au sol
func _joueurEstAuSol() -> bool:
	return joueur.raycastJoueurSol.is_colliding()


##permet d'evaluer si le joueur peut ouvrir son inventaire par rapport a
##l'etat actuel du joueur
func _evaluerAfficherInventaireJeu() -> bool:
	return Input.is_action_just_pressed("inventaire_joueur") and !get_tree().paused
