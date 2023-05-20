class_name InventaireJoueur extends abstractInventaire 

func _ready():
	listeInventaire.connect("item_clicked", selectionnerObjet)
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)



func selectionnerObjet(indexObjet, positionClic, indexBouttonSouris) -> void:
	if inventaireDestination != null and inventaireDestination.visible:
		transfererInventaireJoueur(indexObjet)


##permet d'effectuer le transfert d'un objet de l'inventaire joueur
##vers l'inventaire de destination
func transfererInventaireJoueur(indexObjet : int) -> void:
	var listeInventaireDestination : ItemList = inventaireDestination.get_node("ItemList")
	print("CLIC! dans l'inventaire JOUEUR")
	print(listeInventaire.get_item_text(indexObjet))
	listeInventaireDestination.add_item(listeInventaire.get_item_text(indexObjet))
	listeInventaire.remove_item(indexObjet)
