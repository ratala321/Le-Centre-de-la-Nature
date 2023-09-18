class_name Coffre
extends AbstractObjetInteractif


func effectuer_interaction(interacteur : Node) -> void:
	if interacteur.has_node("InventaireJoueur"):
		var inventaire_coffre : AbstractInventaire = get_node("InventaireCoffre") as AbstractInventaire

		_afficher_interfaces(inventaire_coffre, interacteur.inventaire_joueur)
		_ajouter_references_inventaire_destination(inventaire_coffre, interacteur.inventaire_joueur)


func _afficher_interfaces(inventaire_coffre : AbstractInventaire,
		inventaire_interacteur : AbstractInventaire) -> void:
	inventaire_coffre.afficher_interface(self.get_tree())
	inventaire_interacteur.afficher_interface(self.get_tree())


func _ajouter_references_inventaire_destination(inventaire_coffre : AbstractInventaire,
		inventaire_interacteur : AbstractInventaire) -> void:
	inventaire_coffre.inventaire_destination = inventaire_interacteur
	inventaire_interacteur.inventaire_destination = inventaire_coffre
