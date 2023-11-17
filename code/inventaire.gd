## Classe abstraite contenant les methodes communes a tous les inventaires.
class_name AbstractInventaire
extends CanvasLayer


## Chaque dictionnaire doit contenir trois clefs :[br]
## - nom_dans_inventaire : String[br]
## - chemin_scene_objet : String[br]
## - donnees_objet_inventaire : Dictionary["parametre_correspondant_dans_objet" : valeurParametre]
@export var inventaire_par_defaut : Array[Dictionary]

var liste_inventaire : ItemList
@onready var chemin_fichier_sauvegarde_partiel : String = (
	_determiner_chemin_fichier_sauvegarde_partiel()
)


func _ready():
	ready_instance_inventaire()
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)
	charger_contenu_inventaire()


## Methode destinee a etre redefinie dans l'enfant heritant de self.[br]
## Elle sera appelee au debut de _ready.
func ready_instance_inventaire() -> void:
	pass


func _physics_process(_delta):
	if self.visible and Input.is_key_pressed(KEY_Q):
		cacher_interface()


func _determiner_chemin_fichier_sauvegarde_partiel() -> String:
	liste_inventaire = %ListeInventaire
	var proprietaire_inventaire : Node = get_parent()
	return proprietaire_inventaire.name


func _notification(what):
	if _fermeture_jeu_est_demandee(what):
		var donnees_contenu_inventaire : Array[Dictionary] = _obtenir_donnees_contenu_inventaire()

		var objets_sauvegardes : Dictionary = { "objets_sauvegardes" : donnees_contenu_inventaire}

		SauvegardeInventaire.sauvegarder_donnees_contenu_inventaire(
			objets_sauvegardes, chemin_fichier_sauvegarde_partiel
		)


func _fermeture_jeu_est_demandee(what) -> bool:
	return what == NOTIFICATION_WM_CLOSE_REQUEST


func _obtenir_donnees_contenu_inventaire() -> Array[Dictionary]:
	var donnees : Array[Dictionary] = []
	for i in range(0, liste_inventaire.item_count):
		var objet_sauvegarde : Dictionary = _creer_objet_sauvegarde(i)

		donnees.push_back(objet_sauvegarde)

	return donnees


func _creer_objet_sauvegarde(index : int) -> Dictionary:
	var instance_objet_inventaire : Node = liste_inventaire.get_item_metadata(index)

	var nom_dans_inventaire : String = liste_inventaire.get_item_text(index)
	var chemin_scene_objet : String = instance_objet_inventaire.scene_file_path
	var donnees_objet_inventaire : Dictionary =(
		instance_objet_inventaire.construire_dictionnaire_donnees_a_sauvegarder()
	)

	var objet_sauvegarde : Dictionary = {
		"nom_dans_inventaire" : nom_dans_inventaire,
		"chemin_scene_objet" : chemin_scene_objet,
		"donnees_objet_inventaire" : donnees_objet_inventaire
	}

	return objet_sauvegarde


func afficher_interface(scene_en_cours : SceneTree) -> void:
	show()
	# Important pour pouvoir cacher l'interface après
	set_process_mode(PROCESS_MODE_ALWAYS)
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	scene_en_cours.paused = true


func cacher_interface() -> void:
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	set_process_mode(PROCESS_MODE_WHEN_PAUSED)


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


func ajouter_collectionnable_a_inventaire(collectionnable : Collectionnable) -> void:
	var resultat_recherche : int = _rechercher_collectionnables_doublons(collectionnable)

	if _aucun_collectionnables_doublons_sont_trouves(resultat_recherche):
		_ajouter_nouveau_collectionnable(collectionnable)
	else:
		_mettre_a_jour_doublon_collectionnable(resultat_recherche)
		collectionnable.queue_free()


func _aucun_collectionnables_doublons_sont_trouves(resultat_recherche : int) -> bool:
	return resultat_recherche < 0


const RESULTAT_DOUBLON_NON_TROUVE : int = -1
## Recherche un doublon equivalent au collectionnable dans l'inventaire.[br]
## [br]
## [param collectionnable] nouveau collectionnable qui peut etre un doublon potentiel.[br]
## [br]
## Retourne l'index du doublon s'il est trouve.[br]
## Retourne un nombre negatif, dans le cas contraire.
func _rechercher_collectionnables_doublons(collectionnable : Collectionnable) -> int:
	# Permet d'obtenir le nom du collectionnable dans l'inventaire sans le nombre
	# de collectionnable. Sans ce regex, le recherche ne trouverait jamais d'equivalence
	# etant donne qu'il faudrait que le nombre de collectionnable dans le nom soit le meme.
	var regex_objet_sans_chiffre : RegEx = RegEx.new()
	regex_objet_sans_chiffre.compile("[a-zA-z].*[a-zA-z]$")

	var index_resultat_recherche : int = RESULTAT_DOUBLON_NON_TROUVE
	var i : int = 0
	while _recherche_collectionnables_doublons_est_incomplete(i, index_resultat_recherche):
		index_resultat_recherche =(
			_mettre_a_jour_index_resultat_recherche(collectionnable, i, regex_objet_sans_chiffre)
		)

		i += 1

	return index_resultat_recherche


## [param index_en_cours] index de l'objet de l'inventaire en cours de comparaison.[br]
## [param index_resultat_recherche] valeur du resultat de la recherche, contenant l'index de
## l'objet doublon dans l'inventaire.[br]
## [br]
## Retourne [b]vrai[/b] lorsque la recherche est incomplete.[br]
## Retourne [b]faux[/b] dans le cas contraire.[br]
func _recherche_collectionnables_doublons_est_incomplete(index_en_cours : int,
		index_resultat_recherche : int) -> bool:
	return (
		index_resultat_recherche == RESULTAT_DOUBLON_NON_TROUVE and
		index_en_cours < liste_inventaire.item_count
	)


## Met a jour l'index du resultat de recherche pendant la recherche d'un doublon
## dans l'inventaire par rapport a un collectionnable ramasse.[br]
## [br]
## [param collectionnable] collectionnable sur lequel la mise a jour se base.[br]
## [param index_en_cours] index de l'objet de l'inventaire en cours de comparaison.[br]
## [param regex_objet_sans_chiffre] regex permettant d'obtenir le nom d'un objet sans chiffre.[br]
func _mettre_a_jour_index_resultat_recherche(
		collectionnable : Collectionnable, index_en_cours : int, regex_objet_sans_chiffre) -> int:
	var index_a_jour = RESULTAT_DOUBLON_NON_TROUVE

	if _objet_inventaire_et_collectionnable_sont_doublons(
		collectionnable, index_en_cours, regex_objet_sans_chiffre
	):
		index_a_jour = index_en_cours

	return index_a_jour


## [param collectionnable] collectionnable etant compare a l'objet dans l'inventaire.[br]
## [param index_objet_inventaire] index de l'objet, qui sera compare, dans l'inventaire.[br]
## [param regex_objet_sans_chiffre] regex permettant d'obtenir le nom d'un objet sans chiffre.[br]
## [br]
## Retourne [b]vrai[/b] lorsque qu'un objet de l'inventaire et le collectionnable sont doublons.[br]
## Retourne [b]faux[/b] dans le cas contraire.[br]
func _objet_inventaire_et_collectionnable_sont_doublons(collectionnable : Collectionnable,
		index_objet_inventaire : int, regex_objet_sans_chiffre : RegEx) -> bool:
	var nom_objet_inventaire : String = liste_inventaire.get_item_text(index_objet_inventaire)

	var resultat_recherche : RegExMatch = regex_objet_sans_chiffre.search(nom_objet_inventaire)

	return (
		not resultat_recherche.strings.is_empty() and
		resultat_recherche.strings[0] == collectionnable.nom
	)


## Permet d'ajouter le nouveau collectionnable dans l'inventaire
func _ajouter_nouveau_collectionnable(collectionnable : Collectionnable) -> void:
	collectionnable.compteur_collectionnable += 1

	liste_inventaire.add_item(collectionnable.nom)
	liste_inventaire.set_item_metadata(-1, collectionnable)
	liste_inventaire.set_item_icon(-1, collectionnable.icone_inventaire)


## Met a jour un collectionnable contenu dans l'inventaire lorsqu'un doublon est trouve.[br]
## [br]
## [param index_doublon_inventaire] index ou se trouve le doublon dans l'inventaire.
func _mettre_a_jour_doublon_collectionnable(index_doublon_inventaire : int) -> void:
	var doublon_collectionnable : Collectionnable =(
		liste_inventaire.get_item_metadata(index_doublon_inventaire) as Collectionnable
	)

	if doublon_collectionnable:
		doublon_collectionnable.compteur_collectionnable += 1

		_mettre_a_jour_nom_doublon_collectionnable(
			doublon_collectionnable, index_doublon_inventaire
		)


## Met a jour le nom du doublon collectionnable lorsqu'un doublon est trouve.[br]
## [br]
## [param doublon_collectionnable] doublon dont le nom doit etre mis a jour.[br]
## [param index_doublon_inventaire] index ou se trouve le doublon dans l'inventaire.
func _mettre_a_jour_nom_doublon_collectionnable(
		doublon_collectionnable : Collectionnable, index_doublon_inventaire : int) -> void:
	var nom_mis_a_jour : String =(
		str(doublon_collectionnable.compteur_collectionnable) +
		" " +
		doublon_collectionnable.nom
	)

	liste_inventaire.set_item_text(index_doublon_inventaire, nom_mis_a_jour)


#----------------------------------
# Permet d'effectuer la procedure de selection d'un objet dans un inventaire.
# Doit etre connectee au signal ItemClicked d'un ItemList.
# abstract effecuter_procedure_selection_objet(index, at_position, mouse_button_index) -> void:
