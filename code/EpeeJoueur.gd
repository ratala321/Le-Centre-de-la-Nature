extends abstractOutils

const numeroIdentificationEpee : int = 0
const nomEpee : = "epee"

func _init(durabilite : int = 100):
	super(numeroIdentificationEpee, nomEpee, durabilite) 


##
func effectuerProcedureSelection() -> void:
	print("PROCEDURE EPEE")
	pass

##
func estObjetDeMain() -> void:
	print("temporaire")
	pass
