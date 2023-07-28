class_name InventaireJoueur extends abstractInventaire 

@onready var joueur : JoueurCanard = get_parent()

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
		var referenceMain : BoneAttachment3D = _obtenirReferenceMainJoueur(referenceObjet)
		if _joueurPossedeObjetDansMain(referenceMain):
			_retirerObjetDansMain(referenceObjet, null)
		else:
			_ajouterObjetDansMain(referenceObjet, null)


func _objetPossedeUneProcedureDeSelection(referenceObjet) -> bool:
	#return referenceObjet != null and referenceObjet.has_method("effectuerProcedureSelection")
	return referenceObjet != null and ObjetEquipable.implementeInterface(referenceObjet)


@onready var referenceMainDroite : BoneAttachment3D = (joueur.
	get_node("KayKit_AnimatedCharacter_v13/KayKit Animated Character2/Skeleton3D/MainEmplacementDroit"))
@onready var referenceMainGauche : BoneAttachment3D = (joueur.
	get_node("KayKit_AnimatedCharacter_v13/KayKit Animated Character2/Skeleton3D/MainEmplacementGauche"))
func _obtenirReferenceMainJoueur(referenceObjet : Variant):
	#methode dans objet pour savoir si main gauche ou droite
	#if (methode) get main droite
	#sinon main gauche
	pass


func _joueurPossedeObjetDansMain(referenceMain : BoneAttachment3D) -> bool:
	return referenceMain.get_child_count() != 0


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
