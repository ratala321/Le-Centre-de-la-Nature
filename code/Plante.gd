extends AnimatableBody3D

var dureeCroissance : int
var referenceSolFertile


func _init(dureeCroissance : int, referenceSolFertile):
	self.dureeCroissance = dureeCroissance
	self.referenceSolFertile = referenceSolFertile


func avancerCroissance(intervalleTemps) -> void:
	dureeCroissance = dureeCroissance - intervalleTemps

	if croissanceEstFinie():
		print("croissance " + self.name + " est finie")


func croissanceEstFinie() -> bool:
	return dureeCroissance == 0
