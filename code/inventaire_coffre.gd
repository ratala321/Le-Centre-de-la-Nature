class_name InventaireCoffre
extends AbstractInventaire


## Methode redefinie. Appelee depuis le _ready du parent.
func ready_instance_inventaire() -> void:
	liste_inventaire.connect("item_clicked", effectuer_procedure_selection_objet)
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)


## Permet d'effectuer le transfert d'un objet d'un coffre
## vers l'inventaire de destination
func effectuer_procedure_selection_objet(
		index_objet, _position_clic,_index_boutton_souris) -> void:
	transferer_objet_vers_inventaire_destination(index_objet)
