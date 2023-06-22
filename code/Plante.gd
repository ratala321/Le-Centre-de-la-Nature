extends AnimatableBody3D

@export var etapesCroissance : Array

const dureeCroissanceInitiale : int = 10

var etapeCroissanceActuelle = 0
var dureeCroissance : int = dureeCroissanceInitiale
var referenceSolFertile


#func _init(dureeCroissance : int, referenceSolFertile):
#	self.dureeCroissance = dureeCroissance
#	self.referenceSolFertile = referenceSolFertile


func avancerCroissance(intervalleTemps) -> void:
	dureeCroissance = dureeCroissance - intervalleTemps

	if croissanceEstFinie():
		print("croissance " + self.name + " est finie")
		get_node(etapesCroissance[etapeCroissanceActuelle]).hide()
		etapeCroissanceActuelle += 1
		get_node(etapesCroissance[etapeCroissanceActuelle]).show()


func croissanceEstFinie() -> bool:
	return dureeCroissance == 0


func couperPlante() -> void:
	pass
