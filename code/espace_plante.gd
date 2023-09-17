class_name EspacePlante
extends Area3D


var _contient_une_previsualisation : bool = false


func _ready():
	self.connect("area_exited", _retirer_previsualisation_apres_sortie_joueur)


func ajouter_plante_dans_espace(scene_plante : PackedScene) -> void:
	if _ne_contient_pas_une_plante():
		var instance_plante : Plante = scene_plante.instantiate()
		_effectuer_processus_ajout_plante(instance_plante)


func _ne_contient_pas_une_plante() -> bool:
	return not _contient_une_plante()


@export var _reference_sol_fertile : SolFertile
func _effectuer_processus_ajout_plante(plante : Plante) -> void:
	_ajuster_emplacement_plante(plante)

	plante.ajouter_reference_sol_fertile(_reference_sol_fertile)

	add_child(plante)


func _ajuster_emplacement_plante(plante : Node3D) -> void:
	_ajuster_emplacement_previsualisation(plante)


func _contient_une_plante() -> bool:
	var enfants_scene : Array[Node] = get_children()
	var i : int = 0
	while i < enfants_scene.size() and _enfant_n_est_pas_une_plante(enfants_scene[i]):
		i += 1
	
	return i < enfants_scene.size()


func _enfant_n_est_pas_une_plante(enfant : Node) -> bool:
	return not _enfant_est_une_plante(enfant)


func _enfant_est_une_plante(enfant : Node) -> bool:
	return enfant as Plante != null and enfant != _plante_en_previsualisation


func previsualiser_plante(scene_plante : PackedScene) -> void:
	if not _contient_une_previsualisation:
		var instance_plante : Node3D = scene_plante.instantiate()
		_effecuter_processus_previsualisation(instance_plante)


var _plante_en_previsualisation : Node
func _effecuter_processus_previsualisation(plante : Node3D) -> void:
	_sauvegarder_reference_previsualisation(plante)

	_ajuster_emplacement_previsualisation(plante)
	
	_afficher_previsualisation(plante)

	_ajouter_previsualisation_dans_scene(plante)


func _sauvegarder_reference_previsualisation(plante : Node3D) -> void:
	_plante_en_previsualisation = plante


func _ajuster_emplacement_previsualisation(plante : Node3D) -> void:
	var emplacement_previsualisation : Marker3D = $PositionPlante as Marker3D

	plante.position = emplacement_previsualisation.position


const ETAPE_CROISSANCE_INITIALE : String = "Initial"
const PREVISUALISATION_PLANTE : String = "Previsualisation"
func _afficher_previsualisation(plante : Node3D) -> void:
	var etape_croissance_initiale : Node3D = plante.get_node(ETAPE_CROISSANCE_INITIALE) as Node3D
	etape_croissance_initiale.hide()

	var previsualisation_plante : Node3D = plante.get_node(PREVISUALISATION_PLANTE) as Node3D
	previsualisation_plante.show()


func _ajouter_previsualisation_dans_scene(plante : Node3D) -> void:
	add_child(plante)
	_contient_une_previsualisation = true


func _retirer_previsualisation_apres_sortie_joueur(aire_sortie : Area3D) -> void:
	if _peut_retirer_previsualisation(aire_sortie):
		_plante_en_previsualisation.queue_free()
		_plante_en_previsualisation = null
		_contient_une_previsualisation = false


const AIRE_PERMETTANT_PREVISUALISATION : String = "AireDetectionEspacePlante"
func _peut_retirer_previsualisation(aire_sortie : Area3D) -> bool:
	return _contient_une_previsualisation and aire_sortie.name == AIRE_PERMETTANT_PREVISUALISATION
