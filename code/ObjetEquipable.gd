class_name ObjetEquipable extends abstractInterface

const methodesRequisesPourImplementation : Array = (
		["effectuerProcedureSelection", "estObjetDeMain"]
	)


static func implementeInterface(objet) -> bool:
	return verifierImplementationInterface(objet, methodesRequisesPourImplementation)
