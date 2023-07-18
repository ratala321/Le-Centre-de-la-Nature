class_name InventaireCoffre extends abstractInventaire

const epeeClasse = preload("res://scenes/EpeeJoueur.tscn")


func _ready():
	listeInventaire.connect("item_clicked", _selectionnerObjet)
	chargerContenuInventaire()
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)


##permet d'effectuer le transfert d'un objet d'un coffre
##vers l'inventaire de destination
func _selectionnerObjet(indexObjet, positionClic, indexBouttonSouris) -> void:
	transfererObjetVersInventaireDestination(indexObjet)
