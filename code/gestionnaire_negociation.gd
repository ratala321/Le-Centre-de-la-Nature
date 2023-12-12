class_name GestionnaireNegociation
extends Node
## Permet de gerer l'interface de negociation entre deux entites.[br]
## L'interface de negociation est un espace intermediaire dans lequel les
## objets qui seront achetes ou vendus se trouvent.[br]
## Le gestionnaire permet, en autre, de calculer le prix de vente,
## de transferer les objets vers les bons inventaires, etc.[br]


## Liste d'inventaire de l'entite qui vend.
@export var _liste_inventaire_marchand : ItemList

## Liste d'inventaire correspondant a l'espace de negociation
@export var _liste_inventaire_negociation : ItemList

@export var _interface_liste_inventaire_joueur : ItemList

## TODO connexion bouttons negociations + transfert basique marchand <--> nego
@export_category("Bouttons negociation")

@export var _confirmation : Button

@export var _reinitialisation : Button

@export var _quitter : Button


func _ready():
	_confirmation.connect("pressed", _effectuer_transaction)
	
	_reinitialisation.connect("pressed", _reinitialiser_transaction)
	
	_quitter.connect("pressed", _quitter_transaction)


var _copie_liste_inventaire_joueur

func afficher_interface_negociation(liste_inventaire_joueur : ItemList) -> void:
	_copie_liste_inventaire_joueur = liste_inventaire_joueur

	_interface_liste_inventaire_joueur.clear()

	_copier_inventaire_joueur_vers_interface(liste_inventaire_joueur)

	owner.show()


func _copier_inventaire_joueur_vers_interface(liste_inventaire_joueur : ItemList) -> void:
	for i in range(0, liste_inventaire_joueur.item_count):
		var nom_objet : String = liste_inventaire_joueur.get_item_text(i)

		var icone_objet : Texture2D = liste_inventaire_joueur.get_item_icon(i)

		_interface_liste_inventaire_joueur.add_item(nom_objet, icone_objet)


## Permet d'effectuer la transaction lors de la confirmation de l'echange par le joueur.
func _effectuer_transaction() -> void:
	pass


## Permet de reinitialiser la transaction a l'etat initial, sans objets en negociation.
func _reinitialiser_transaction() -> void:
	pass


## Permet de quitter la transaction en cours, autrement dit de revenir au jeu.
func _quitter_transaction() -> void:
	pass
