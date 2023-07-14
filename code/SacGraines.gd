extends RigidBody3D

#load ajouté pour des tests temporaires
var graineContenue : PackedScene = load("res://scenes/plantesScenes/BleScene.tscn")

var aireDetectionSolFertile : Area3D
func _ready():
	aireDetectionSolFertile = $AireDetectionEspacePlante
	$IntervalleDetectionEspacesPlantes.connect("timeout", _effectuerProcedurePrevisualisationPlante)


const PrevisualisationEspacePlante = preload("res://code/PrevisualisationEspacePlante.gd")
func _effectuerProcedurePrevisualisationPlante():
	PrevisualisationEspacePlante.previsualiserPlanteDansSacGraines(aireDetectionSolFertile, graineContenue)
