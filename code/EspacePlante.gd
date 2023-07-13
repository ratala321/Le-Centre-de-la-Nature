extends Area3D

const ETAPE_CROISSANCE_INITIALE : String = "Initial"
const PREVISUALISATION_PLANTE : String = "Previsualisation"
const AIRE_PERMETTANT_PREVISUALISATION : String = "AireDetectionEspacePlante"

var contientUnePrevisualisation : bool = false
var previsualisationEnCours : Node

func _ready():
	self.connect("area_exited", _retirerPrevisualisationPlante)

func previsualiserPlante(planteScene : PackedScene):
	if not contientUnePrevisualisation:
		contientUnePrevisualisation = true
		var plante = planteScene.instantiate()
		_effectuerProcedurePrevisualisationPlante(plante)


func _effectuerProcedurePrevisualisationPlante(plante : Node):
	previsualisationEnCours = plante
	_ajusterEmplacementPrevisualisation(plante)
	_afficherNodePrevisualisation(plante)
	_ajoutPrevisualisationDansScene(plante)
	print("ajout previsualisation plante")


func _ajusterEmplacementPrevisualisation(plante : Node):
	plante.position = $PositionPlante.position


func _afficherNodePrevisualisation(plante : Node):
	plante.get_node(ETAPE_CROISSANCE_INITIALE).hide()
	plante.get_node(PREVISUALISATION_PLANTE).show()


func _ajoutPrevisualisationDansScene(plante : Node):
		add_child(plante)


func _retirerPrevisualisationPlante(aireSortie : Area3D):
	if _peutRetirerPrevisulation(aireSortie):
		previsualisationEnCours.queue_free()
		contientUnePrevisualisation = false


func _peutRetirerPrevisulation(aireSortie : Area3D) -> bool:
	return contientUnePrevisualisation and aireSortie.name == AIRE_PERMETTANT_PREVISUALISATION
