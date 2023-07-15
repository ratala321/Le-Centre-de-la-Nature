extends RigidBody3D

const DetectionEspacePlante = preload("res://code/DetectionEspacePlante.gd")

static func previsualiserPlanteDansSacGraines(aireDetectionSolFertile : Area3D,
graineContenue : PackedScene) -> void:
	var airesEnCollision = aireDetectionSolFertile.get_overlapping_areas()
	var resultatDetection : int = DetectionEspacePlante.detecterEspacePlante(airesEnCollision)
	if _espacePlanteEstDetectee(resultatDetection):
		airesEnCollision[resultatDetection].previsualiserPlante(graineContenue)


static func _espacePlanteEstDetectee(resultatDetection : int):
	return !resultatDetection < 0
