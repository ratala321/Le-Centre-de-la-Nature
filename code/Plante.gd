extends AnimatableBody3D

@export var etapesCroissance : Array


var referenceSolFertile
func ajouterReferenceSolFertile(referenceSolFertile):
	self.referenceSolFertile = referenceSolFertile
	self.referenceSolFertile.ajouterPlanteAuSol(self)

var referenceEspacePlante
func ajouterReferenceEspacePlante(referenceEspacePlante):
	self.referenceSolFertile = referenceSolFertile
	self.referenceSolFertile.ajouterPlanteAuSol(self)


const dureeCroissanceInitiale : int = 10
var dureeCroissance : int = dureeCroissanceInitiale
var etapeCroissanceActuelle : int = 0
func avancerCroissance(intervalleTemps) -> void:
	dureeCroissance = dureeCroissance - intervalleTemps

	if _croissanceEstFinie() and _resteDesEtapesDeCroissance():
		print("croissance " + self.name + " est finie")
		get_node(etapesCroissance[etapeCroissanceActuelle]).hide()
		etapeCroissanceActuelle += 1
		get_node(etapesCroissance[etapeCroissanceActuelle]).show()
		dureeCroissance = dureeCroissanceInitiale


func _croissanceEstFinie() -> bool:
	return dureeCroissance <= 0


func _resteDesEtapesDeCroissance() -> bool:
	return etapeCroissanceActuelle < etapesCroissance.size() - 1


func couperPlante() -> void:
	pass
