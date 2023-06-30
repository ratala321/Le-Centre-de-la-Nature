extends abstractObjetInteractif

@export var plantesContenues : Array

const tempsAvancement : int = 1

func _init():
	super(self)


func _ready():
	super._ready()
	get_node("Timer").connect("timeout", avancerCroissancePlantes, 0)


func avancerCroissancePlantes():
	for planteRef in plantesContenues:
		var plante = get_node(planteRef)
		plante.avancerCroissance(tempsAvancement)
	pass


func ajouterPlanteAuSol(plante) -> void:
	plantesContenues.push_back(plante)


func interaction():
	print("interaction sol fertile")
