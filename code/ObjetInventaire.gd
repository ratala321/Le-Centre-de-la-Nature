class_name abstractObjetInventaire extends Node3D

var numeroIdentificationObjetInventaire : int : set = setNumeroIdentification, get = getNumeroIdentification
var nomObjetInventaire : String : set = setNomObjetInventaire, get = getNomObjetInventaire
var enCoursUtilisation : bool = false : set = setEnCoursUtilisation, get = getEnCoursUtilisation
#exemple outils, nourriture, sorts, etc.
var typeObjetInventaire : String


func _init(numeroIdentification : int, nom : String, type : String):
	numeroIdentificationObjetInventaire = numeroIdentification
	nomObjetInventaire = nom
	typeObjetInventaire = type


#---------------------------
#Accesseurs et Modificateurs
#---------------------------

func setNomObjetInventaire(nom : String) -> void:
	nomObjetInventaire = nom


func getNomObjetInventaire() -> String:
	return nomObjetInventaire
	
	
func setNumeroIdentification(numeroIdentification : int) -> void:
	numeroIdentificationObjetInventaire = numeroIdentification


func getNumeroIdentification() -> int:
	return numeroIdentificationObjetInventaire


func setEnCoursUtilisation(etatUtilisation) -> void:
	enCoursUtilisation = etatUtilisation


func getEnCoursUtilisation() -> bool:
	return enCoursUtilisation


#-------------------------------------------------------------------------------------------
#Methode abstraite effectuerProcedureSelection permettant d'effectuer une suite
#d'instructions lorsqu'un objet est selectionne dans l'inventaire
#-------------------------------------------------------------------------------------------
