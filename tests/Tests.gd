extends Node

@export var testsSontActives : bool

const planteTest = preload("res://scenes/plantesScenes/BleScene.tscn")

@onready var timer = $Timer
var solTest

func _ready():
	solTest = get_node("../SolFertile")
	timer.connect("timeout", testEspacePlante)


func testEspacePlante():
	if testsSontActives:
		var conteneur = solTest.get_node("ConteneurEspacePlante")
		var espaceTest = conteneur.get_node("EspacePlante0")
		print("TEST " + str(espaceTest.contientUnePrevisualisation))
		espaceTest.previsualiserPlante(planteTest)
		print("TEST" + str(espaceTest.contientUnePrevisualisation))
