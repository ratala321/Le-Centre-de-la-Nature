class_name ObjetInteractif extends AnimatableBody3D

##reference au joueur instancie dans la scene
@export var joueur : CharacterBody3D
##reference l'aire d'interaction instanciee dans la scene
@export var aireInteraction : Area3D

##signal emis pour lancer l'interaction d'un objet interactif
signal interaction_

func _ready():
	joueur.connect("interaction_joueur_", _lors_interaction_joueur, 0)



##methode connectee au signal [signal interaction_joueur_] permettant
##de proceder a l'interaction correspondant à l'objet
func _lors_interaction_joueur() -> void:
	#verifier que le joueur est dans l'aire d'interaction
	if aireInteraction.overlaps_body(joueur):
		print("interaction!")
		emit_signal("interaction_")
