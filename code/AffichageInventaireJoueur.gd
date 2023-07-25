class_name AffichageInventaireJoueur extends Node

var joueur : JoueurCanard
func _init(joueur : JoueurCanard):
	self.joueur = joueur


##permet d'afficher l'inventaire du joueur conditionnellement
func afficherInventaireJoueur() -> void:
	if Input.is_action_just_pressed("inventaire_joueur"):
		if _demanderAfficherInventaireJoueur():
			print("permission pour afficher l'inventaire!")
			joueur.get_node("InventaireJoueur").montrerInterface()


##permet d'evaluer si le joueur peut afficher son inventaire
func _demanderAfficherInventaireJoueur() -> bool:
	return _etatJeuPermetAffichageInventaire() and _etatJoueurPermetAffichageInventaire()


##permet d'evaluer si le joueur peut ouvrir son inventaire par rapport a
##l'etat actuel du jeu
func _etatJoueurPermetAffichageInventaire() -> bool:
	return joueur.joueurEstAuSol() and joueur.permissionMouvement


##permet d'evaluer si le joueur peut ouvrir son inventaire par rapport a
##l'etat actuel du joueur
func _etatJeuPermetAffichageInventaire() -> bool:
	return !joueur.get_tree().paused
