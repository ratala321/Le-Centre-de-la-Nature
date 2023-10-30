extends Node

@export var testsSontActifs : bool


@onready var timer = $Timer
func _ready():
	timer.connect("timeout", lancer_transition_camera)


const TestEspacePlante = preload("res://tests/NiveauTest/TestEspacePlante.gd")
func testEspacePlante():
	if testsSontActifs:
		var testEspacePlanteInstance = TestEspacePlante.new()
		add_child(testEspacePlanteInstance)
		testEspacePlanteInstance.lancerTests()


func lancer_transition_camera() -> void:
	TransitionCamera3d.effectuer_transition_basique_camera_3d(
		get_node("../JoueurCanard/AxeRotationCamera/Camera3DJoueur"),
		get_node("../Destination"),
		4.0)
