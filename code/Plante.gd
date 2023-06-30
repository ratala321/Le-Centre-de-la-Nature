extends AnimatableBody3D
#implements ObjetInventaire

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

	if croissanceEstFinie() and resteDesEtapesDeCroissance():
		print("croissance " + self.name + " est finie")
		get_node(etapesCroissance[etapeCroissanceActuelle]).hide()
		etapeCroissanceActuelle += 1
		get_node(etapesCroissance[etapeCroissanceActuelle]).show()
		dureeCroissance = dureeCroissanceInitiale


func croissanceEstFinie() -> bool:
	return dureeCroissance <= 0


func resteDesEtapesDeCroissance() -> bool:
	return etapeCroissanceActuelle < etapesCroissance.size() - 1


func couperPlante() -> void:
	pass


func effectuerProcedureSelection():
	pass
