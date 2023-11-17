class_name InventaireJoueur
extends AbstractInventaire


@onready var _joueur : JoueurCanard = get_parent() as JoueurCanard


## Methode redefinie. Appelee depuis le _ready du parent.
func ready_instance_inventaire() -> void:
	liste_inventaire.connect("item_clicked", effectuer_procedure_selection_objet)
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)


func effectuer_procedure_selection_objet(
		index_objet, _position_clic, _index_boutton_souris) -> void:
	if _joueur_tente_transferer_objet():
		_retirer_objet_main_joueur(index_objet)
		transferer_objet_vers_inventaire_destination(index_objet)
	else:
		var metadata_objet_selectionne : Variant = liste_inventaire.get_item_metadata(index_objet)
		_lancer_procedure_pour_objet_selectionnable(metadata_objet_selectionne)


func _lancer_procedure_pour_objet_selectionnable(metadata_objet_selectionne : Variant) -> void:
	if _est_un_objet_selectionnable_depuis_inventaire(metadata_objet_selectionne):
		_liberer_main_joueur(metadata_objet_selectionne)
		metadata_objet_selectionne.effectuer_procedure_selection_depuis_inventaire(_joueur)


func _est_un_objet_selectionnable_depuis_inventaire(metadata_objet_selectionne) -> bool:
	return metadata_objet_selectionne.has_method("effectuer_procedure_selection_depuis_inventaire")


func _joueur_tente_transferer_objet() -> bool:
	return inventaire_destination != null and inventaire_destination.is_visible()


func _retirer_objet_main_joueur(index_objet : int) -> void:
	var metadata_objet_selectionne : Variant = liste_inventaire.get_item_metadata(index_objet)

	if metadata_objet_selectionne.has_method("effectuer_procedure_retrait_main_joueur"):
		metadata_objet_selectionne.effectuer_procedure_retrait_main_joueur(_joueur)


var _fonctions_liberer_main_joueur : Array[Callable] =(
	[
		func (): print("n'est pas objet equipable en main"),
		func (instance_joueur : JoueurCanard, metadata_objet_selectionne : Variant):
			instance_joueur.liberer_main_droite(metadata_objet_selectionne),
		func (instance_joueur : JoueurCanard, metadata_objet_selectionne : Variant):
			instance_joueur.liberer_main_gauche(metadata_objet_selectionne),
		func (instance_joueur : JoueurCanard, metadata_objet_selectionne : Variant):
			instance_joueur.liberer_deux_mains(metadata_objet_selectionne)
]
)
func _liberer_main_joueur(metadata_objet_selectionne : Variant) -> void:
	var fonction_liberer_main : Callable =(
		_fonctions_liberer_main_joueur[metadata_objet_selectionne.est_outils_de_main()]
	)
	fonction_liberer_main.call(_joueur, metadata_objet_selectionne)
