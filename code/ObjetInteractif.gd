class_name abstractObjetInteractif extends AnimatableBody3D

##reference au joueur instancie dans la scene
@export var joueur : CharacterBody3D

##reference l'aire d'interaction instanciee dans la scene
@onready var aireInteraction : Area3D = get_node("AireInteractionCoffre")

##reference a la classe enfant
var objetInteractif


func _init(objetInteractifInstancie):
	objetInteractif = objetInteractifInstancie

	
func _ready():
	joueur.connect("interaction_joueur_", _lors_interaction_joueur, 0)



##methode connectee au signal [signal interaction_joueur_] permettant
##de proceder a l'interaction correspondant à l'objet
func _lors_interaction_joueur() -> void:
	#verifier que le joueur est dans l'aire d'interaction
	if joueurEstDansAireInteraction():
		print("interaction!")
		objetInteractif.interaction()


func joueurEstDansAireInteraction() -> bool:
	return aireInteraction.overlaps_body(joueur)

#------------------------------------------------------------------------------------------
#Methode abstraite interaction() qui force les objets interactifs a definir une interaction
#------------------------------------------------------------------------------------------
