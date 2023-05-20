class_name CoffreInteractif extends ObjetInteractif
##note sur l'implementation
##On doit ajouter un area2D (AireInteractionCoffre) et un AnimationPlayer (AnimationPlayerCoffre)

@onready var animationPlayerCoffre = get_node("AnimationPlayerCoffre")
@onready var inventaireCoffre = get_node("InventaireCoffre")
@onready var inventaireJoueur = joueur.get_node("InventaireJoueur")

signal affichage_inventaire_coffre_

func _init():
	super(self)


##permet d'effectuer la serie de methodes liees a l'interaction
##avec l'objet
func interaction():
	print("YOUPI coffre interaction")
	$InventaireCoffre.montrerInterface()
	$InventaireCoffre.ajouterReferenceInventaireDestination(inventaireJoueur)
	joueur.afficherInventaireJoueurEntreposage(inventaireCoffre)
