extends Node

@export var testsSontActives : bool


@onready var timer = $Timer
func _ready():
	timer.connect("timeout", testEspacePlante)


const TestEspacePlante = preload("res://tests/NiveauTest/TestEspacePlante.gd")
func testEspacePlante():
	if testsSontActives:
		var testEspacePlanteInstance = TestEspacePlante.new()
		add_child(testEspacePlanteInstance)
		testEspacePlanteInstance.main()
