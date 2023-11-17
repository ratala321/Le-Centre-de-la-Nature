class_name DialoguesMarchand
extends Node


func afficher_dialogues_marchand() -> void:
	$InterfaceUtilisateur.visible = true

	_lancer_transition_affichage_ui()


func cacher_dialogues_marchand() -> void:
	$InterfaceUtilisateur.visible = false

	_lancer_transition_cacher_ui()


const OFFSET_BAS_ECRAN_Y : int = 400

const OFFSET_MILIEU_ECRAN_Y : int = 0

func _lancer_transition_affichage_ui() -> void:
	var tween : Tween = get_tree().create_tween()

	self.offset.y = OFFSET_BAS_ECRAN_Y

	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "offset", Vector2(self.offset.x, OFFSET_MILIEU_ECRAN_Y), 1.0)

	await tween.finished


func _lancer_transition_cacher_ui() -> void:
	var tween : Tween = get_tree().create_tween()

	self.offset.y = OFFSET_MILIEU_ECRAN_Y

	tween.tween_property(self, "offset", Vector2(self.offset.x, OFFSET_BAS_ECRAN_Y), 1.0)

	await tween.finished
