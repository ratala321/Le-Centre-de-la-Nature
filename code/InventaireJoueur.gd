class_name InventaireJoueur extends abstractInventaire 

func _ready():
	listeInventaire.connect("item_clicked", selectionnerObjet)
	chargerContenuInventaire()
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)


##fonction appelee lors du signal item_clicked
func selectionnerObjet(indexObjet, positionClic, indexBouttonSouris) -> void:

	if joueurTenteEffectuerTransfertObjet():
		transfererObjetVersInventaireDestination(indexObjet)
	else:
		var referenceObjet : Variant = listeInventaire.get_item_metadata(indexObjet)

		if objetPossedeUneProcedureDeSelection(referenceObjet):
			referenceObjet.effectuerProcedureSelection()


func joueurTenteEffectuerTransfertObjet() -> bool:
	return inventaireDestination != null and inventaireDestination.visible



func objetPossedeUneProcedureDeSelection(referenceObjet) -> bool:
	return referenceObjet != null and referenceObjet.has_method("effectuerProcedureSelection")
