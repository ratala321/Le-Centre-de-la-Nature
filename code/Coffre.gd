class_name CoffreInteractif extends ObjetInteractif

@onready var animationPlayerCoffre = get_node("AnimationPlayerCoffre")
signal affichage_inventaire_coffre_

func _init():
	super(self)


##permet d'effectuer la serie de methodes liees a l'interaction
##avec l'objet
func interaction():
	print("YOUPI coffre interaction")
	$InventaireCoffre.montrerInterface()
	#pour afficher l'inventaire du joueur aussi
	emit_signal("affichage_inventaire_coffre_")
