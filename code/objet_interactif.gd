class_name AbstractObjetInteractif
extends AnimatableBody3D

##reference l'aire d'interaction instanciee dans la scene
@onready var aireInteraction : Area3D = get_node("AireInteraction")

#------------------------------------
# Permet d'effectuer une serie d'instructions liee a l'interaction associee a l'objet interactif.
# abstract effectuer_interaction(interacteur : Node) -> void:
