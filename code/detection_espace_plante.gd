class_name DetectionEspacePlante
extends Node


## Retourne l'index de l'espace plante detecte, autrement retourne -1.
static func detecter_espace_plante(airesDetectees : Array) -> int:
	var i : int = 0
	while i < airesDetectees.size() and _n_est_pas_espace_plante(airesDetectees[i]):
		i += 1

	if _aucune_aire_est_espace_plante:
		i = -1

	return i - 1


static func _n_est_pas_espace_plante(aireDetectee) -> bool:
		return not _est_espace_plante(aireEnCollision)


const espacePlanteGroupe : String = "EspacePlante"
static func _est_espace_plante(aireDetectee) -> bool:
	return aireEnCollision.is_in_group(espacePlanteGroupe)


static func _aucune_aire_est_espace_plante(nombreAires : int, indexEnCours : int) -> bool:
	return indexEnCours >= nombreAires
