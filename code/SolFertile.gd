extends Node3D

const tempsAvancement : int = 1

@export var plantesContenues : Array

func _ready():
	get_node("Timer").connect("timeout", avancerCroissancePlantes, 0)


func avancerCroissancePlantes():
	for planteRef in plantesContenues:
		var plante = get_node(planteRef)
		plante.avancerCroissance(tempsAvancement)
	pass


func ajouterPlanteAuSol(plante) -> void:
	plantesContenues.push_back(plante)
