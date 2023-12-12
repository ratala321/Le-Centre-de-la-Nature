class_name DialoguesMarchand
extends CanvasLayer


## Est vrai lorsque le marchand est en cours de dialogue.
var dialogue_en_cours : bool = false


func _ready():
	%ButtonQuitter.connect("pressed", _effectuer_procedure_cacher_interface_dialogue)

	%ButtonDiscuter.connect("pressed", _effectuer_procedure_discussion)

	%ButtonQuitterDialogue.connect("pressed", _afficher_options_apres_dialogue)

	%ButtonMarchander.connect("pressed", _preparer_interface_negociation)

	process_mode = PROCESS_MODE_WHEN_PAUSED


func _process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		_effectuer_procedure_cacher_interface_dialogue()


func afficher_options_dialogues_marchand() -> void:
	get_tree().paused = true

	$OptionsDialogue.show()
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

	_lancer_transition_affichage_ui()


func cacher_dialogues_marchand() -> void:
	dialogue_en_cours = false

	await _lancer_transition_cacher_ui()
	
	_inventaire_marchand.hide()
	$OptionsDialogue.hide()


signal boutton_quitter_clique

func _effectuer_procedure_cacher_interface_dialogue() -> void:
	if dialogue_en_cours:
		cacher_dialogues_marchand()

		boutton_quitter_clique.emit()


func _afficher_options_apres_dialogue() -> void:
	$Discussion.visible = false

	$OptionsDialogue.visible = true


@onready var _inventaire_marchand : CanvasLayer = get_node("../InventaireMarchand")

## Contenu de l'inventaire du joueur en contact avec le marchand.[br]
var liste_inventaire_joueur : ItemList

func _preparer_interface_negociation() -> void:
	if dialogue_en_cours:	
		_inventaire_marchand.offset.y = 0

		_cacher_options_dialogue_discussion()

		var gestionnaire_nego : GestionnaireNegociation =(
			_inventaire_marchand.get_node("GestionnaireNegociation") as GestionnaireNegociation
		)
		gestionnaire_nego.afficher_interface_negociation(liste_inventaire_joueur)


func _effectuer_procedure_discussion() -> void:
	if dialogue_en_cours:
		_cacher_options_dialogue_discussion()

		_traduire_dialogue()

		_afficher_dialogue()

		_passer_au_prochain_suffixe_dialogue()


func _cacher_options_dialogue_discussion() -> void:
	$OptionsDialogue.hide()


const PREFIXE_CLEF_DIALOGUE : String = "DIALOGUE_MARCHAND_"

var _suffixe_clef_dialogue : int = 0

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

## Temps de transition de l'affichage ou de la disparition de l'UI
@export var _temps_transition_ui : float = 1.0

func _lancer_transition_affichage_ui() -> void:
	var tween : Tween = get_tree().create_tween()

	self.offset.y = OFFSET_BAS_ECRAN_Y

	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.set_parallel(true)
	
	tween.tween_property(
		self, "offset", Vector2(self.offset.x, OFFSET_MILIEU_ECRAN_Y), _temps_transition_ui)

	await tween.finished


func _lancer_transition_cacher_ui() -> void:
	var tween : Tween = get_tree().create_tween()
	
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.set_parallel(true)

	self.offset.y = OFFSET_MILIEU_ECRAN_Y

	tween.tween_property(
		self, "offset", Vector2(self.offset.x, OFFSET_BAS_ECRAN_Y), _temps_transition_ui)
	
	tween.tween_property(
		_inventaire_marchand, "offset",
		Vector2(_inventaire_marchand.offset.x, OFFSET_BAS_ECRAN_Y * 2), _temps_transition_ui)
	
	await tween.finished
