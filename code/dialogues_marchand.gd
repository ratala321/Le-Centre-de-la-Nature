class_name DialoguesMarchand
extends Node


func _ready():
	%ButtonQuitter.connect("pressed", _effectuer_procedure_cacher_interface_dialogue)


func afficher_dialogues_marchand() -> void:
	$InterfaceUtilisateur.visible = true

	_lancer_transition_affichage_ui()

	Input.mouse_mode = Input.MOUSE_MODE_CONFINED


func cacher_dialogues_marchand() -> void:
	$InterfaceUtilisateur.visible = false

	_lancer_transition_cacher_ui()


signal boutton_quitter_clique

func _effectuer_procedure_cacher_interface_dialogue() -> void:
	cacher_dialogues_marchand()

	emit_signal("boutton_quitter_clique")

	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


const OFFSET_BAS_ECRAN_Y : int = 400

const OFFSET_MILIEU_ECRAN_Y : int = 0

func _lancer_transition_affichage_ui() -> void:
	var tween : Tween = get_tree().create_tween()

	self.offset.y = OFFSET_BAS_ECRAN_Y

	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "offset", Vector2(self.offset.x, OFFSET_MILIEU_ECRAN_Y), 1.0)


func _lancer_transition_cacher_ui() -> void:
	var tween : Tween = get_tree().create_tween()

	self.offset.y = OFFSET_MILIEU_ECRAN_Y

	tween.tween_property(self, "offset", Vector2(self.offset.x, OFFSET_BAS_ECRAN_Y), 1.0)
