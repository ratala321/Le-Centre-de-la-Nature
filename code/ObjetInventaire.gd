class_name abstractObjetInventaire extends Node3D

var numeroIdentificationOutils : int
var nomOutils : String : set = setNomOutils, get = getNomOutils
var durabiliteOutils : int = 100


func _init(numeroIdentification : int, nom : String, durabilite : int = 100):
	numeroIdentificationOutils = numeroIdentification
	nomOutils = nom
	durabiliteOutils = durabilite


#---------------------------
#Accesseurs et Modificateurs
#---------------------------

func setNomOutils(nom : String) -> void:
	nomOutils = nom


func getNomOutils() -> String:
	return nomOutils
	
	
func setNumeroIdentification(numeroIdentification : int) -> void:
	numeroIdentificationOutils = numeroIdentification


func getNumeroIdentification() -> int:
	return numeroIdentificationOutils


func setDurabiliteOutils(durabilite) -> void:
	durabiliteOutils = durabilite


func getDurabiliteOutils() -> int:
	return durabiliteOutils
