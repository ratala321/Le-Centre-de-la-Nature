extends RigidBody3D

#load ajouté pour des tests temporaires
var graineContenue : PackedScene = load("res://scenes/plantesScenes/BleScene.tscn")

var aireDetectionSolFertile : Area3D
func _ready():
	aireDetectionSolFertile = $AireDetectionEspacePlante
	$IntervalleDetectionEspacesPlantes.connect("timeout", _detecterEspacePlante)


const DetectionEspacePlante = preload("res://code/DetectionEspacePlante.gd")
func _detecterEspacePlante():
	DetectionEspacePlante.previsualiserPlanteDansSacGraines(aireDetectionSolFertile, graineContenue)
