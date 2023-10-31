class_name PatronRelais
extends Node


@export var nom_methode_relais : String = ""
var methode_relais : Callable


func _ready():
	if nom_methode_relais:
		methode_relais = Callable(get_parent(), nom_methode_relais)


func utiliser_relais(appelant : Node) -> void:
	if methode_relais:
		methode_relais.call(appelant)
