class_name InventaireJoueur extends abstractInventaire 

func _ready():
	listeInventaire.connect("item_clicked", selectionnerObjet)
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)



func selectionnerObjet(indexObjet, positionClic, indexBouttonSouris) -> void:
	if inventaireDestination != null and inventaireDestination.visible:
		transfererInventaire(indexObjet)


