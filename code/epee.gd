class_name Epee
extends AbstractOutils


const nomEpee : = "epee"


func _init():
	super._init(self)


func _physics_process(delta):
	if Input.is_action_pressed("action_principale_outils") and _est_en_main:
		effecter_action_principale(delta)


func effecter_action_principale(_delta) -> void:
	#TODO
	print("PROCEDURE EPEE")


func est_outils_de_main() -> int:
	return VALEUR_OUTILS_MAIN_DROITE
