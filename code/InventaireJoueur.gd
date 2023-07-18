class_name InventaireJoueur extends abstractInventaire 

func _ready():
	listeInventaire.connect("item_clicked", selectionnerObjet)
	chargerContenuInventaire()
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)


##fonction appelee lors du signal item_clicked
func selectionnerObjet(indexObjet, positionClic, indexBouttonSouris) -> void:

	if _joueurTenteEffectuerTransfertObjet():
		transfererObjetVersInventaireDestination(indexObjet)
	else:
		var referenceObjet : Variant = listeInventaire.get_item_metadata(indexObjet)

		if _objetPossedeUneProcedureDeSelection(referenceObjet):
			referenceObjet.effectuerProcedureSelection()


func _joueurTenteEffectuerTransfertObjet() -> bool:
	return inventaireDestination != null and inventaireDestination.visible


func _effectuerProcedureSelectionObjet(referenceObjet : Variant) -> void:
	if _objetPossedeUneProcedureDeSelection(referenceObjet):
		# referenceMain = _obtenirReferenceMainJoueur(referenceObjet)
		if _joueurPossedeObjetDansMain():
			_retirerObjetDansMain(referenceObjet, null)
		else:
			_ajouterObjetDansMain(referenceObjet, null)


func _objetPossedeUneProcedureDeSelection(referenceObjet) -> bool:
	return referenceObjet != null and referenceObjet.has_method("effectuerProcedureSelection")


func _obtenirReferenceMainJoueur(referenceObjet : Variant):
	#methode dans objet pour savoir si main gauche ou droite
	#if (methode) get main droite
	#sinon main gauche
	pass


func _joueurPossedeObjetDansMain() -> bool:
	return get_parent().objetDansMain


func _retirerObjetDansMain(referenceObjet : Variant, referenceMain) -> void:
	referenceObjet.effectuerProcedureSelection()
	print()
	#referenceMainremove_child(referenceObjet)
	pass
	

func _ajouterObjetDansMain(referenceObjet : Variant, referenceMain) -> void:
	#referenceMain.add_child(referenceObjet)
	referenceObjet.effectuerProcedureSelection()
	print()
	pass
