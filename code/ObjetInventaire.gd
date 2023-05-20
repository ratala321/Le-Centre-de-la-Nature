class_name abstractObjetInventaire extends Node3D

var numeroIdentificationOutils : int
var nomOutils : String : set = setNomOutils, get = getNomOutils


func _init(numeroIdentification : int, nom : String):
	numeroIdentificationOutils = numeroIdentification
	nomOutils = nom


func setNomOutils(nom : String) -> void:
	nomOutils = nom


func getNomOutils() -> String:
	return nomOutils
	
	
func setNumeroIdentification(numeroIdentification : int) -> void:
	numeroIdentificationOutils = numeroIdentification


func getNumeroIdentification() -> int:
	return numeroIdentificationOutils
