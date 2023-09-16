class_name InventaireJoueur
extends AbstractInventaire 


@onready var _joueur : JoueurCanard = get_parent() as JoueurCanard


func _ready():
	super._ready()
	liste_inventaire.connect("item_clicked", effectuer_procedure_selection_objet)
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)


func effectuer_procedure_selection_objet(index_objet, position_clic, index_boutton_souris) -> void:
	if _joueur_tente_transferer_objet():
		transferer_objet_vers_inventaire_destination(index_objet)
	else:
		var metadata_objet_selectionne : Variant = liste_inventaire.get_item_metadata(index_objet)
		_lancer_procedure_pour_objet_selectionnable(metadata_objet_selectionne)


func _lancer_procedure_pour_objet_selectionnable(metadata_objet_selectionne : Variant) -> void:
	if _est_un_objet_selectionnable_depuis_inventaire(metadata_objet_selectionne):
		metadata_objet_selectionne.effecuter_procedure_selection_depuis_inventaire(_joueur)


func _est_un_objet_selectionnable_depuis_inventaire(metadata_objet_selectionne) -> bool:
	return metadata_objet_selectionne.has_method("effecuter_procedure_selection_depuis_inventaire")


func _joueur_tente_transferer_objet() -> bool:
	return inventaire_destination.is_visible()
