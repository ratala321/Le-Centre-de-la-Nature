@static_unload
class_name DetectionEspacePlante
extends Node


## Retourne l'index de l'espace plante detecte, autrement retourne -1.
static func detecter_espace_plante(aires_detectees : Array) -> int:
	var i : int = 0
	while i < aires_detectees.size() and _n_est_pas_espace_plante(aires_detectees[i]):
		i += 1

	if _aucune_aire_est_espace_plante:
		i = -1

	return i - 1


static func _n_est_pas_espace_plante(aire_detectee) -> bool:
		return not _est_espace_plante(aire_detectee)


const espacePlanteGroupe : String = "EspacePlante"
static func _est_espace_plante(aire_detectee) -> bool:
	return aire_detectee.is_in_group(espacePlanteGroupe)


static func _aucune_aire_est_espace_plante(nombreAires : int, indexEnCours : int) -> bool:
	return indexEnCours >= nombreAires
