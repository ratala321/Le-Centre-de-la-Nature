class_name CoffreInteractif extends ObjetInteractif

@onready var animationPlayerCoffre = get_node("AnimationPlayerCoffre")

func _init():
	super(self)


##permet d'effectuer la serie de methodes liees a l'interaction
##avec l'objet
func interaction():
	print("YOUPI coffre interaction")
	$InventaireJoueur.montrerInterface()
