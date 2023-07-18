class_name abstractOutils extends abstractObjetInventaire

var durabiliteOutils : int = 100
const type : String = "outils"


func _init(numeroIdentification : int, nom : String, durabilite : int):
	super(numeroIdentification, nom, type)
	durabiliteOutils = durabilite
	pass


#-------------------------------------------------------------------------------------------
#Methode abstraite effectuerProcedureSelection permettant d'effectuer une suite
#d'instructions lorsqu'un objet est selectionne dans l'inventaire
#-------------------------------------------------------------------------------------------
