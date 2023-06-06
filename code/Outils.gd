class_name abstractOutils extends abstractObjetInventaire

var durabiliteOutils : int = 100 : set = setDurabiliteOutils, get = getDurabiliteOutils
const type : String = "outils"


func _init(numeroIdentification : int, nom : String, durabilite : int):
	super(numeroIdentification, nom, type)
	durabiliteOutils = durabilite
	pass


#---------------------------
#Accesseurs et Modificateurs
#---------------------------
func setDurabiliteOutils(durabilite) -> void:
	durabiliteOutils = durabilite


func getDurabiliteOutils() -> int:
	return durabiliteOutils


#-------------------------------------------------------------------------------------------
#Methode abstraite effectuerProcedureSelection permettant d'effectuer une suite
#d'instructions lorsqu'un objet est selectionne dans l'inventaire
#-------------------------------------------------------------------------------------------
