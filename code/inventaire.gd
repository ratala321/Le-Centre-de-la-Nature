class_name AbstractInventaire
extends Control


## duo nomObjet et sceneObjet, exemple :
## index = 0 -> nomObjet1, index = 1 -> pathSceneObjet1, index = 2 -> nomObjet2 ...
@export var inventaire_par_defaut : Array

var liste_inventaire : ItemList
@onready var chemin_fichier_sauvegarde_partiel : String = _determiner_chemin_fichier_sauvegarde_partiel()


func _ready():
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)
	charger_contenu_inventaire()


func _determiner_chemin_fichier_sauvegarde_partiel() -> String:
	liste_inventaire = get_node("ItemList")
	var proprietaire_inventaire : Node = get_parent()
	return proprietaire_inventaire.name


func _notification(what):
	if _fermeture_jeu_est_demandee(what):
		var donnees_a_sauvegarder : Array[DonneesObjetInventaire] = _obtenir_donnees_contenu_inventaire()
		SauvegardeInventaire.sauvegarder_donnees_contenu_inventaire(donnees_a_sauvegarder, chemin_fichier_sauvegarde_partiel)


func _fermeture_jeu_est_demandee(what) -> bool:
	return what == NOTIFICATION_WM_CLOSE_REQUEST


func _obtenir_donnees_contenu_inventaire() -> Array:
	var donnees : Array = []
	for i in range(0, liste_inventaire.item_count):
		var nom_objet : String = liste_inventaire.get_item_text(i)

		var chemin_scene_objet : String = _obtenir_chemin_scene_objet(i)

		donnees.push_back(DonneesObjetInventaire.new(nom_objet, chemin_scene_objet))
	
	return donnees


const MESSAGE_ERREUR_CHARGEMENT_CHEMIN : String =(
"Erreur lors du chargement du chemin de la scene de l'objet a sauvegarder")
func _obtenir_chemin_scene_objet(index : int) -> String:
	var chemin_scene_objet : String = MESSAGE_ERREUR_CHARGEMENT_CHEMIN

	var instance_objet : Node = liste_inventaire.get_item_metadata(index)

	if instance_objet != null:
		chemin_scene_objet = instance_objet.scene_file_path
	
	return chemin_scene_objet


func afficher_interface(scene_en_cours : SceneTree) -> void:
	show()
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	scene_en_cours.paused = true


func cacher_interface() -> void:
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false


var inventaire_destination : AbstractInventaire
func transferer_objet_vers_inventaire_destination(index_objet : int) -> void:
	_copier_objet_vers_destination(inventaire_destination.liste_inventaire, index_objet)
	_copier_metadata_vers_destination(inventaire_destination.liste_inventaire, index_objet)
	_retirer_objet_transfere_inventaire(index_objet)


func _copier_objet_vers_destination(destination : ItemList, index_objet : int) -> void:
	var nom_objet : String = liste_inventaire.get_item_text(index_objet)
	destination.add_item(nom_objet)


func _copier_metadata_vers_destination(destination : ItemList, index_objet : int) -> void:
	var metadata_objet : Node = liste_inventaire.get_item_metadata(index_objet)
	var index_objet_destination : int = destination.item_count - 1

	destination.set_item_metadata(index_objet_destination, metadata_objet)


func _retirer_objet_transfere_inventaire(index_objet : int) -> void:
	liste_inventaire.remove_item(index_objet)


func charger_contenu_inventaire() -> void:
	ChargementInventaire.charger_donnees_contenu_inventaire(self)

#----------------------------------
# Permet d'effectuer la procedure de selection d'un objet dans un inventaire.
# Doit etre connectee au signal ItemClicked d'un ItemList.
# abstract effecuter_procedure_selection_objet(index, at_position, mouse_button_index) -> void:
