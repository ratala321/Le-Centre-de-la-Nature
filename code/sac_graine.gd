class_name SacGraine
extends AbstractOutils


# load ajouté pour des tests temporaires
var _graine_contenue : PackedScene = load("res://scenes/plantesScenes/BleScene.tscn")

@onready var _aire_detection_espace_plante : Area3D = $AireDetectionEspacePlante as Area3D


func _ready():
	var intervalle_detection_espace_plante : Timer = $IntervalleDetectionEspacesPlantes as Timer

	intervalle_detection_espace_plante.connect("timeout",
		_effectuer_procedure_previsualisation_plante)


func _init():
	super._init(self)


func _physics_process(_delta):
	effectuer_action_principale()


func effectuer_action_principale() -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		_effecuter_fonction_sur_espace_plante(Callable(self, "_ajouter_plante_dans_espace"))


func _effectuer_procedure_previsualisation_plante() -> void:
	_effecuter_fonction_sur_espace_plante(Callable(self, "_previsualiser_plante"))


## Cherche un EspacePlante a portee du sac et applique la fonction sur cet EspacePlante
## Effectue la fonction sur le premier EspacePlante trouve
func _effecuter_fonction_sur_espace_plante(fonction_a_appliquer : Callable):
	var aires_detectees : Array[Area3D] =(
		_aire_detection_espace_plante.get_overlapping_areas()
	)
	var resultat_recherche : int = DetectionEspacePlante.detecter_espace_plante(aires_detectees)

	if _espace_plante_est_detecte(resultat_recherche):
		fonction_a_appliquer.call(aires_detectees[resultat_recherche])


func _ajouter_plante_dans_espace(espace_plante_detecte : EspacePlante) -> void:
	espace_plante_detecte.ajouter_plante_dans_espace(_graine_contenue)


func _previsualiser_plante(espace_plante : EspacePlante) -> void:
	espace_plante.previsualiser_plante(_graine_contenue)


func _espace_plante_est_detecte(resultat_recherche : int) -> bool:
	return resultat_recherche >= 0


func est_outils_de_main() -> int:
	return VALEUR_OUTILS_MAIN_GAUCHE 
