extends GutTest


var instance_inventaire : Control


func before_all():
	var dir_access = DirAccess.open("user://")
	dir_access.make_dir("tests")
	

func before_each():
	var aire_interaction : Area3D = _creer_aire_interaction()

	var instance_coffre = _creer_instance_coffre()

	instance_inventaire = _creer_instance_inventaire()

	_ajouter_instances_dans_scene(instance_coffre, aire_interaction)


const CHEMIN_FICHIER_TEST_ABSOLU : String = "user://tests/" + NOM_INSTANCE_COFFRE + ".txt"
func after_each():
	_liberer_contenu_inventaire()

	DirAccess.remove_absolute(CHEMIN_FICHIER_TEST_ABSOLU)


const CHEMIN_FICHIER_TEST_PARTIEL : String = "tests/" + NOM_INSTANCE_COFFRE
func test_charger_inventaire_sauvegarde():
	var donnees_a_sauvegarder : Array[DonneesObjetInventaire] = _initialiser_contenu_inventaire_chemins_invalides()

	SauvegardeInventaire.sauvegarder_donnees_contenu_inventaire(donnees_a_sauvegarder, CHEMIN_FICHIER_TEST_PARTIEL)

	instance_inventaire.chemin_fichier_sauvegarde_partiel = CHEMIN_FICHIER_TEST_PARTIEL

	ChargementInventaire.charger_donnees_contenu_inventaire(instance_inventaire)

	assert_eq(instance_inventaire.liste_inventaire.item_count, 2,
		"Erreur, le nombre d'objet contenu dans l'inventaire devrait etre de deux")


func test_noms_objets_charges():
	var donnees_a_sauvegarder : Array[DonneesObjetInventaire] = _initialiser_contenu_inventaire_chemins_invalides()

	SauvegardeInventaire.sauvegarder_donnees_contenu_inventaire(donnees_a_sauvegarder, CHEMIN_FICHIER_TEST_PARTIEL)

	instance_inventaire.chemin_fichier_sauvegarde_partiel = CHEMIN_FICHIER_TEST_PARTIEL

	ChargementInventaire.charger_donnees_contenu_inventaire(instance_inventaire)

	var contenu_inventaire : ItemList = instance_inventaire.liste_inventaire

	assert_true(contenu_inventaire.get_item_text(0) == "nomObjetTest" and
		contenu_inventaire.get_item_text(1) == "Jonh",
		"Erreur, l'un des noms d'objets charges n'est pas le bon")


func test_metadata_chargee_invalide():
	var donnees_a_sauvegarder : Array[DonneesObjetInventaire] = _initialiser_contenu_inventaire_chemins_invalides()

	SauvegardeInventaire.sauvegarder_donnees_contenu_inventaire(donnees_a_sauvegarder, CHEMIN_FICHIER_TEST_PARTIEL)

	instance_inventaire.chemin_fichier_sauvegarde_partiel = CHEMIN_FICHIER_TEST_PARTIEL

	ChargementInventaire.charger_donnees_contenu_inventaire(instance_inventaire)

	var contenu_inventaire : ItemList = instance_inventaire.liste_inventaire

	assert_true(contenu_inventaire.get_item_metadata(0) == null and
		contenu_inventaire.get_item_metadata(1) == null,
		"Erreur, lors du chargement d'un chemin de scene invalide, le metadata devrait etre null")


func test_metadata_chargee_valide():
	var donnees_a_sauvegarder : Array[DonneesObjetInventaire] = _initialiser_contenu_inventaire_chemins_valides()

	SauvegardeInventaire.sauvegarder_donnees_contenu_inventaire(donnees_a_sauvegarder, CHEMIN_FICHIER_TEST_PARTIEL)

	instance_inventaire.chemin_fichier_sauvegarde_partiel = CHEMIN_FICHIER_TEST_PARTIEL

	ChargementInventaire.charger_donnees_contenu_inventaire(instance_inventaire)

	var contenu_inventaire : ItemList = instance_inventaire.liste_inventaire

	assert_true(contenu_inventaire.get_item_metadata(0).scene_file_path == CHEMIN_SCENE_TEST and
		contenu_inventaire.get_item_metadata(1).scene_file_path == CHEMIN_SCENE_TEST,
		"Erreur, le chemin de l'instance chargee ne correspond pas au resultat attendu")


func _creer_aire_interaction() -> Area3D:
	var aire_interaction : Area3D = autoqfree(Area3D.new())
	aire_interaction.set_name("AireInteraction")

	var collision_shape : CollisionShape3D = autoqfree(CollisionShape3D.new())
	collision_shape.set_shape(SphereShape3D.new())

	aire_interaction.add_child(collision_shape)

	return aire_interaction


func _creer_instance_inventaire() -> Control:
	var scene_inventaire_coffre : PackedScene = load("res://scenes/InventaireCoffre.tscn")
	
	return autoqfree(scene_inventaire_coffre.instantiate())


const NOM_INSTANCE_COFFRE : String = "TestChargement"
func _creer_instance_coffre() -> Node:
	var scene_coffre : PackedScene = load("res://scenes/Coffre.tscn")
	
	var instance_coffre = autoqfree(scene_coffre.instantiate())

	instance_coffre.set_name(NOM_INSTANCE_COFFRE)

	return instance_coffre


func _ajouter_instances_dans_scene(instance_coffre : Node, aire_interaction : Node) -> void:
	instance_coffre.add_child(instance_inventaire)
	
	instance_coffre.add_child(aire_interaction)
	
	add_child_autoqfree(instance_coffre)


func _initialiser_contenu_inventaire_chemins_invalides() -> Array[DonneesObjetInventaire]:
	var donnees_a_sauvegarder : Array[DonneesObjetInventaire] = []

	donnees_a_sauvegarder.push_back(DonneesObjetInventaire.new("nomObjetTest", "nomCheminTest"))
	donnees_a_sauvegarder.push_back(DonneesObjetInventaire.new("Jonh", "Road"))

	return donnees_a_sauvegarder


const CHEMIN_SCENE_TEST : String = "res://tests/scene_de_test.tscn"
func _initialiser_contenu_inventaire_chemins_valides() -> Array[DonneesObjetInventaire]:
	var donnees_a_sauvegarder : Array[DonneesObjetInventaire] = []

	donnees_a_sauvegarder.push_back(DonneesObjetInventaire.new("nom", CHEMIN_SCENE_TEST))
	donnees_a_sauvegarder.push_back(DonneesObjetInventaire.new("allo", CHEMIN_SCENE_TEST))

	return donnees_a_sauvegarder


func _liberer_contenu_inventaire():
	var liste_inventaire = instance_inventaire.liste_inventaire

	for i in range(0, liste_inventaire.item_count):
		var objet_inventaire = liste_inventaire.get_item_metadata(i)

		if (objet_inventaire != null and objet_inventaire.has_method("queue_free")):
			objet_inventaire.queue_free()
