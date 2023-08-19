class_name abstractInterface extends Node

static func verifierImplementationInterface(objet, methodesRequisesPourImplementation : Array) -> bool:	
	var neManqueAucuneMethode : bool = true
	for methodeRequise in methodesRequisesPourImplementation:
		if _objetNePossedePasMethodeRequise(objet, methodeRequise):
			neManqueAucuneMethode = false
	return neManqueAucuneMethode


static func _objetNePossedePasMethodeRequise(objet, methodeRequise : String) -> bool:
	print(methodeRequise)
	print(objet.has_method(methodeRequise))
	return not objet.has_method(methodeRequise)

#-------------------------------------------------------------------------------------------
#Methode abstraite implementeInterface(objet) 
#Permet de verifier si un objet implemente une interface
#-------------------------------------------------------------------------------------------
