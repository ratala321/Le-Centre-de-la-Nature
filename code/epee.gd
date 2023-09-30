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
	proprietaire.changer_etat_animation("Attack(1h)")
	
	_creer_chronometre_reactivation_physics_process()
	
	# Eviter qu'on puise donner 9209 coups a la seconde
	self.set_physics_process(false)


func est_outils_de_main() -> int:
	return VALEUR_OUTILS_MAIN_DROITE


const TEMPS_EXECUTION_ANIMATION_EPEE : float = 0.9
func _creer_chronometre_reactivation_physics_process() -> void:
	var chrono_reactivation : Timer = Timer.new()
	
	chrono_reactivation.one_shot = true
	
	chrono_reactivation.connect("timeout", _reactiver_physics_process_depuis_chrono)
	
	chrono_reactivation.name = "chrono_reactivation"
	
	add_child(chrono_reactivation)
	
	chrono_reactivation.start(TEMPS_EXECUTION_ANIMATION_EPEE)


func _reactiver_physics_process_depuis_chrono() -> void:
	_liberer_chronometre_reactivation_physics_process()
	
	self.set_physics_process(true)


func _liberer_chronometre_reactivation_physics_process() -> void:
	var chrono_reactivation : Timer = get_node("chrono_reactivation") as Timer
	
	chrono_reactivation.disconnect("timeout", _reactiver_physics_process_depuis_chrono)
	
	chrono_reactivation.queue_free()
