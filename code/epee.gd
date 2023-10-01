class_name Epee
extends AbstractOutils


const nomEpee : = "epee"

## Indique si l'epee en cours d'utilisation, autrement dit si le joueur
## est en train de frapper avec (animation qui joue)
var _est_en_utilisation : bool = false


func _init():
	super._init(self)


func _ready():
	self.connect("body_entered", _analyser_objets_en_collision)


func _physics_process(delta):
	if Input.is_action_pressed("action_principale_outils") and _est_en_main:
		effecter_action_principale(delta)


const VITESSE_ANIMATION_EPEE : float = 1.5
func effecter_action_principale(_delta) -> void:
	proprietaire.changer_etat_animation("Attack(1h)", VITESSE_ANIMATION_EPEE)
	
	_creer_chronometre_reactivation_physics_process()
	
	_est_en_utilisation = true
	
	# Eviter qu'on puise donner 9209 coups a la seconde
	self.set_physics_process(false)


func est_outils_de_main() -> int:
	return VALEUR_OUTILS_MAIN_DROITE


const TEMPS_EXECUTION_ANIMATION_EPEE : float = 0.9
const NOM_CHRONO_REACTIVATION_PHYSICS_PROCESS : String = "chrono_reactivation"
func _creer_chronometre_reactivation_physics_process() -> void:
	var chrono_reactivation : Timer = Timer.new()
	
	chrono_reactivation.one_shot = true
	
	chrono_reactivation.connect("timeout", _reactiver_physics_process_depuis_chrono)
	
	chrono_reactivation.name = NOM_CHRONO_REACTIVATION_PHYSICS_PROCESS
	
	add_child(chrono_reactivation)
	
	chrono_reactivation.start(TEMPS_EXECUTION_ANIMATION_EPEE)


func _reactiver_physics_process_depuis_chrono() -> void:
	_liberer_chronometre_reactivation_physics_process()
	
	_est_en_utilisation = false
	
	self.set_physics_process(true)


func _liberer_chronometre_reactivation_physics_process() -> void:
	var chrono_reactivation : Timer = get_node(NOM_CHRONO_REACTIVATION_PHYSICS_PROCESS) as Timer
	
	chrono_reactivation.disconnect("timeout", _reactiver_physics_process_depuis_chrono)
	
	chrono_reactivation.queue_free()


func _analyser_objets_en_collision(objet) -> void:
	if _objet_est_une_plante(objet) and _est_en_utilisation:
		objet.couper_plante()
		_est_en_utilisation = false

func _objet_est_une_plante(objet) -> bool:
	return objet.has_method("couper_plante")
