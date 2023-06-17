class_name InventaireCoffre extends abstractInventaire

const epeeClasse = preload("res://scenes/EpeeJoueur.tscn")

func _ready():
	listeInventaire.connect("item_clicked", selectionnerObjet)
	var epee = epeeClasse.instantiate()
	listeInventaire.add_item("epee")
	listeInventaire.set_item_metadata(listeInventaire.get_item_count()-1, epee)
	chargerContenuInventaire()
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)


##permet d'effectuer le transfert d'un objet d'un coffre
##vers l'inventaire de destination
func selectionnerObjet(indexObjet, positionClic, indexBouttonSouris) -> void:
	transfererObjetVersInventaireDestination(indexObjet)
