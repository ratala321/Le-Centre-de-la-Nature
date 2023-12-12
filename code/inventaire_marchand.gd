class_name InventaireMarchand
extends AbstractInventaire


## Methode redefinie. Appelee depuis le _ready du parent.
func ready_instance_inventaire() -> void:
	liste_inventaire.connect("item_clicked", effectuer_procedure_selection_objet)
	
	super.set_gestion_input_independante(false)


func effectuer_procedure_selection_objet(
		index_objet, _position_clic,_index_boutton_souris) -> void:
	# TODO
	pass
