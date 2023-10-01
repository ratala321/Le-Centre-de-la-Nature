class_name SolFertile
extends AbstractObjetInteractif


## Contient le NodePath de chacune des plantes dans la scene
@export var _plantes_ajoutee_editeur_depart : Array

var _plantes_contenues : Array[Plante]

@onready var chrono_intervalle_croissance : Timer = get_node("IntervalleAvancementCroissance") as Timer


func _ready():
	chrono_intervalle_croissance.connect("timeout", _avancer_croissance_plantes)

	_ajouter_plantes_provenant_editeur()


func _ajouter_plantes_provenant_editeur() -> void:
	if _plantes_ajoutee_editeur_depart != null:
		for chemin_plante in _plantes_ajoutee_editeur_depart:
			var instance_plante : Plante = get_node(chemin_plante) as Plante
			_plantes_contenues.push_back(instance_plante)


const TEMPS_AVANCEMENT : int = 1
func _avancer_croissance_plantes() -> void:
	for plante_contenue in _plantes_contenues:
		plante_contenue.avancer_croissance(TEMPS_AVANCEMENT)


func effectuer_interaction(_interacteur) -> void:
	#TODO
	print("Interaction avec sol fertile")


func ajouter_plante_contenue(plante : Plante) -> void:
	_plantes_contenues.push_back(plante)


func retirer_plante_contenue(plante : Plante) -> void:
	var index_plante : int = _plantes_contenues.find(plante)
	
	if _plante_est_trouvee(index_plante):
		_plantes_contenues.remove_at(index_plante)


func _plante_est_trouvee(index_plante : int) -> bool:
	return not index_plante == -1
