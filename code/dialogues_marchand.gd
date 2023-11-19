class_name DialoguesMarchand
extends Node


func _ready():
	%ButtonQuitter.connect("pressed", _effectuer_procedure_cacher_interface_dialogue)
	%ButtonDiscuter.connect("pressed", _effectuer_procedure_discussion)


func afficher_options_dialogues_marchand() -> void:
	$OptionsDialogue.visible = true

	_lancer_transition_affichage_ui()

	Input.mouse_mode = Input.MOUSE_MODE_CONFINED


func cacher_dialogues_marchand() -> void:
	$OptionsDialogue.visible = false

	_lancer_transition_cacher_ui()


signal boutton_quitter_clique

func _effectuer_procedure_cacher_interface_dialogue() -> void:
	cacher_dialogues_marchand()

	emit_signal("boutton_quitter_clique")

	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


const PREFIXE_CLEF_DIALOGUE : String = "DIALOGUE_MARCHAND_"


var _suffixe_clef_dialogue : int = 0

func _effectuer_procedure_discussion() -> void:
	_cacher_options_dialogue_marchand()

	_traduire_dialogue()

	_afficher_dialogue()

	_passer_au_prochain_suffixe_dialogue()


func _cacher_options_dialogue_marchand() -> void:
	$OptionsDialogue.visible = false


func _traduire_dialogue() -> void:
	print(PREFIXE_CLEF_DIALOGUE + str(_suffixe_clef_dialogue))
	var traduction = tr(PREFIXE_CLEF_DIALOGUE + str(_suffixe_clef_dialogue))
	print(traduction)
	%Dialogue.text = tr(PREFIXE_CLEF_DIALOGUE + str(_suffixe_clef_dialogue))


func _afficher_dialogue() -> void:
	$Discussion.visible = true


func _passer_au_prochain_suffixe_dialogue() -> void:
	_suffixe_clef_dialogue += 1


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
