extends Area3D

const ETAPE_CROISSANCE_INITIALE : String = "Initial"
const PREVISUALISATION_PLANTE : String = "Previsualisation"
const AIRE_PERMETTANT_PREVISUALISATION : String = "AireDetectionEspacePlante"

var contientUnePrevisualisation : bool = false
var previsualisationEnCours : Node

func _ready():
	self.connect("area_exited", retirerPrevisualisationPlante)

func previsualiserPlante(planteScene : PackedScene):
	if not contientUnePrevisualisation:
		contientUnePrevisualisation = true
		var plante = planteScene.instantiate()
		effectuerProcedurePrevisualisationPlante(plante)


func effectuerProcedurePrevisualisationPlante(plante : Node):
	previsualisationEnCours = plante
	ajusterEmplacementPrevisualisation(plante)
	afficherNodePrevisualisation(plante)
	ajoutPrevisualisationDansScene(plante)
	print("ajout previsualisation plante")


func ajusterEmplacementPrevisualisation(plante : Node):
	plante.position = $PositionPlante.position


func afficherNodePrevisualisation(plante : Node):
	plante.get_node(ETAPE_CROISSANCE_INITIALE).hide()
	plante.get_node(PREVISUALISATION_PLANTE).show()


func ajoutPrevisualisationDansScene(plante : Node):
		add_child(plante)


func retirerPrevisualisationPlante(aireSortie : Area3D):
	if peutRetirerPrevisulation(aireSortie):
		previsualisationEnCours.queue_free()
		contientUnePrevisualisation = false


func peutRetirerPrevisulation(aireSortie : Area3D) -> bool:
	return contientUnePrevisualisation and aireSortie.name == AIRE_PERMETTANT_PREVISUALISATION
