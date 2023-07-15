extends RigidBody3D

#load ajouté pour des tests temporaires
var graineContenue : PackedScene = load("res://scenes/plantesScenes/BleScene.tscn")

var aireDetectionSolFertile : Area3D
func _ready():
	aireDetectionSolFertile = $AireDetectionEspacePlante
	$IntervalleDetectionEspacesPlantes.connect("timeout", _effectuerProcedurePrevisualisationPlante)

func _physics_process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		effectuerAction()


const DetectionEspacePlante = preload("res://code/DetectionEspacePlante.gd")
func effectuerAction() -> void:
	var airesDetectees : Array = aireDetectionSolFertile.get_overlapping_areas()
	var resultatRecherche : int = DetectionEspacePlante.detecterEspacePlante(airesDetectees)
	if resultatRecherche >= 0:
		var plante = graineContenue.instantiate()
		var espacePlante = airesDetectees[resultatRecherche]
		var positionPlante = espacePlante.get_node("PositionPlante")
		positionPlante.add_child(plante)
	pass


const PrevisualisationEspacePlante = preload("res://code/PrevisualisationEspacePlante.gd")
func _effectuerProcedurePrevisualisationPlante():
	PrevisualisationEspacePlante.previsualiserPlanteDansSacGraines(aireDetectionSolFertile, graineContenue)
