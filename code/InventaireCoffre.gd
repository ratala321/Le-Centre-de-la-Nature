class_name InventaireCoffre extends abstractInventaire

func _ready():
	listeInventaire.connect("item_clicked", selectionnerObjet)
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)


##permet d'effectuer le transfert d'un objet d'un coffre
##vers l'inventaire de destination
func selectionnerObjet(indexObjet, positionClic, indexBouttonSouris) -> void:
	var listeInventaireDestination : ItemList = inventaireDestination.get_node("ItemList")
	print("CLIC! dans l'inventaire COFFRE")
	print(listeInventaire.get_item_text(indexObjet))
	listeInventaireDestination.add_item(listeInventaire.get_item_text(indexObjet))
	listeInventaire.remove_item(indexObjet)
	pass
