class_name InventaireMarchand
extends CanvasLayer

@export var gestionnaire_negociation : GestionnaireNegociation

func afficher_interface_negociation(liste_inventaire_joueur : ItemList) -> void:
	gestionnaire_negociation.afficher_interface_negociation(liste_inventaire_joueur)
