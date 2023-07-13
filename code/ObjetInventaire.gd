class_name abstractObjetInventaire extends Node3D

var numeroIdentificationObjetInventaire : int
var nomObjetInventaire : String
var enCoursUtilisation : bool = false
#exemple outils, nourriture, sorts, etc.
var typeObjetInventaire : String


func _init(numeroIdentification : int, nom : String, type : String):
	numeroIdentificationObjetInventaire = numeroIdentification
	nomObjetInventaire = nom
	typeObjetInventaire = type


#-------------------------------------------------------------------------------------------
#Methode abstraite effectuerProcedureSelection permettant d'effectuer une suite
#d'instructions lorsqu'un objet est selectionne dans l'inventaire
#-------------------------------------------------------------------------------------------
