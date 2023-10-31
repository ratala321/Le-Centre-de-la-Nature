class_name Coffre
extends AbstractObjetInteractif


func effectuer_interaction_avec_joueur(joueur : JoueurCanard) -> void:
	var inventaire_coffre : AbstractInventaire = $InventaireCoffre as AbstractInventaire

	if joueur.has_node("InventaireJoueur"):
		_afficher_interfaces(inventaire_coffre, joueur.inventaire_joueur)

		_ajouter_references_inventaire_destination(inventaire_coffre, joueur.inventaire_joueur)


func _afficher_interfaces(inventaire_coffre : AbstractInventaire,
		inventaire_interacteur : AbstractInventaire) -> void:
	inventaire_coffre.afficher_interface(self.get_tree())
	inventaire_interacteur.afficher_interface(self.get_tree())


func _ajouter_references_inventaire_destination(inventaire_coffre : AbstractInventaire,
		inventaire_interacteur : AbstractInventaire) -> void:
	inventaire_coffre.inventaire_destination = inventaire_interacteur
	inventaire_interacteur.inventaire_destination = inventaire_coffre
