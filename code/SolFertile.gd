extends abstractObjetInteractif

@export var plantesContenues : Array

const tempsAvancement : int = 1

func _init():
	super(self)


func _ready():
	super._ready()
	$IntervalleAvancementCroissance.connect("timeout", avancerCroissancePlantes, 0)


func avancerCroissancePlantes():
	for planteRef in plantesContenues:
		if _estUnObjet(planteRef):
			planteRef.avancerCroissance(tempsAvancement)
		else:
			var plante = get_node(planteRef)
			plante.avancerCroissance(tempsAvancement)
	pass


func _estUnObjet(planteRef):
	return typeof(planteRef) != TYPE_NODE_PATH


func ajouterPlanteAuSol(plante) -> void:
	plantesContenues.push_back(plante)


func interaction():
	print("interaction sol fertile")
