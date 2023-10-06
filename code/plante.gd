class_name Plante
extends AnimatableBody3D


@export_category("etapes de croissance de la plante")
## Contient les chemins, bases sur le Root Node de la plante, vers chacune des etapes de croissance
@export var _etapes_croissance : Array[NodePath]

@export_category("ble collectionnable a loot par le joueur")
## Collectionnable de la plante qui sera 'drop', ajouter, dans la scene suite a la coupe.
@export var _collectionnable_plante : PackedScene


const DUREE_CROISSANCE_INITALE : int =  10
var _duree_croissance : int = DUREE_CROISSANCE_INITALE
var _etape_croissance_actuelle : int = 0
func avancer_croissance(intervalle_temps : int) -> void:
	_duree_croissance -= intervalle_temps

	if _croissance_est_finie() and _reste_etapes_croissance():
		_croitre_plante_visuellement()

		_duree_croissance = DUREE_CROISSANCE_INITALE


func _croissance_est_finie() -> bool:
	return _duree_croissance <= 0


func _reste_etapes_croissance() -> bool:
	return _etape_croissance_actuelle < _etapes_croissance.size() - 1


func _croitre_plante_visuellement() -> void:
	_cacher_etape_croissance_finie()
	
	_etape_croissance_actuelle += 1

	_afficher_etape_croissance_suivante()


func _cacher_etape_croissance_finie() -> void:
	var scene_etape_croissance_actuelle : Node3D =(
		get_node(_etapes_croissance[_etape_croissance_actuelle])
	)

	scene_etape_croissance_actuelle.hide()


func _afficher_etape_croissance_suivante() -> void:
	var scene_etape_croissance_actuelle : Node3D =(
		get_node(_etapes_croissance[_etape_croissance_actuelle])
	)

	scene_etape_croissance_actuelle.show()


func couper_plante() -> void:
	#TODO condition selon etape croissance plante -> couper au bon moment
	_sol_fertile.retirer_plante_contenue(self)
	
	_ajouter_collectionnable_plante_dans_scene()
	
	self.queue_free()


func _ajouter_collectionnable_plante_dans_scene() -> void:
	var instance_collectionnable = _collectionnable_plante.instantiate()
	
	self.add_sibling(instance_collectionnable)
	
	instance_collectionnable.position = self.position
	# Pour que le collectionnable ne clip pas au sol
	instance_collectionnable.position.y += 2


var _sol_fertile : SolFertile
func ajouter_reference_sol_fertile(reference_sol_fertile : SolFertile) -> void:
	_sol_fertile = reference_sol_fertile
