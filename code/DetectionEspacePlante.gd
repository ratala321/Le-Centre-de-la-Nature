extends RigidBody3D


static func previsualiserPlanteDansSacGraines(aireDetectionSolFertile : Area3D, graineContenue : PackedScene):
	var airesEnCollision = aireDetectionSolFertile.get_overlapping_areas()
	var resultatDetection : int = _detecterEspacePlante(airesEnCollision)
	if _espacePlanteEstDetectee(resultatDetection):
		airesEnCollision[resultatDetection].previsualiserPlante(graineContenue)


static func _espacePlanteEstDetectee(resultatDetection : int):
	return resultatDetection != -1


##retourne l'index de l'espace plante detecte ou -1 lorsque l'espace plante n'est pas detecte
static func _detecterEspacePlante(airesEnCollision : Array) -> int:
	var i : int = 0
	var espaceNEstPasDetecte = true
	while _detectionEstIncomplete(i, airesEnCollision.size(), espaceNEstPasDetecte):
		espaceNEstPasDetecte = _effectuerProcedureDetection(airesEnCollision[i])
		i += 1

	if espaceNEstPasDetecte:
		i = -1

	return i


static func _detectionEstIncomplete(compteurBoucle : int,
 nombreAiresEnCollision : int, nEstPasDetecte : bool) -> bool:
	return compteurBoucle < nombreAiresEnCollision and nEstPasDetecte


static func _effectuerProcedureDetection(aireEnCollision) -> bool:
		return _estEspacePlante(aireEnCollision)


const espacePlanteGroupe : String = "EspacePlante"
static func _estEspacePlante(aireEnCollision) -> bool:
	return aireEnCollision.is_in_group(espacePlanteGroupe)

