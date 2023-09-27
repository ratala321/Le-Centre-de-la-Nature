extends GutTest


var instance_joueur : JoueurCanard
var instance_epee_joueur : AbstractOutils


func before_each():
	var scene_joueur : PackedScene = load("res://scenes/JoueurCanard.tscn")
	var scene_epee_joueur : PackedScene = load("res://scenes/EpeeJoueur.tscn")
	
	instance_joueur = autoqfree(scene_joueur.instantiate())
	instance_epee_joueur = autoqfree(scene_epee_joueur.instantiate())


func after_each():
	var instances_a_liberer : Array = [instance_epee_joueur, instance_joueur]
	
	_vider_inventaires_sauvegardes()
		
	for instance_a_liberer in instances_a_liberer:
		if instance_a_liberer != null:
			instance_a_liberer.queue_free()


func test_bidon():
	add_child_autoqfree((instance_joueur))
	pass_test("ok")


func test_ajout_proprietaire_outils():
	add_child(instance_joueur)

	instance_epee_joueur.effectuer_procedure_selection_depuis_inventaire(instance_joueur)

	assert_eq(instance_epee_joueur.proprietaire, instance_joueur,
		"Erreur, le proprietaire de l'epee aurait du etre instance_joueur")


func test_est_en_main_apres_ajout():
	add_child(instance_joueur)

	instance_epee_joueur.effectuer_procedure_selection_depuis_inventaire(instance_joueur)

	assert_eq(instance_epee_joueur._est_en_main, true,
		"Erreur, l'epee n'a pas ete ajoute dans les mains du joueur ou la valeur indiquant" +
		"le changement n'a pas ete changee")


func test_est_en_main_apres_retrait():
	add_child(instance_joueur)

	instance_epee_joueur.effectuer_procedure_selection_depuis_inventaire(instance_joueur)

	# Retrait
	instance_epee_joueur.effectuer_procedure_selection_depuis_inventaire(instance_joueur)

	assert_eq(instance_epee_joueur._est_en_main, false,
		"Erreur, l'epee n'a pas ete retire des mains du joueur ou la valeur indiquant" +
		"le changement n'a pas ete changee")


func test_est_en_main_apres_retrait_methode_alternative():
	add_child(instance_joueur)

	instance_epee_joueur.effectuer_procedure_selection_depuis_inventaire(instance_joueur)

	instance_epee_joueur.effectuer_procedure_retrait_main_joueur(instance_joueur)

	assert_eq(instance_epee_joueur._est_en_main, false,
		"Erreur, l'epee n'a pas ete retire des mains du joueur ou la valeur indiquant" +
		"le changement n'a pas ete changee")


func test_est_outils_de_main_droite():
	assert_eq(instance_epee_joueur._est_outils_de_main_droite(), true,
		"Erreur, l'outils en question devrait etre de main droite")


func test_est_outils_de_main_gauche():
	assert_eq(instance_epee_joueur._est_outils_de_main_gauche(), false,
		"Erreur, ne devrait pas etre de main gauche")


## Les inventaires chargent leurs donnees sauvegardees au moment de l'entree dans le scene_tree.
## Pour eviter toute erreur dans les tests, il faut vider les inventaires.
func _vider_inventaires_sauvegardes() -> void:
	if _inventaire_joueur_n_est_pas_null(instance_joueur):
		var liste_inventaire : ItemList = instance_joueur.inventaire_joueur.liste_inventaire

		_vider_inventaire_joueur(liste_inventaire)


func _vider_inventaire_joueur(liste_inventaire : ItemList) -> void:
	for i in range(0, liste_inventaire.item_count):
		if _est_objet_pouvant_etre_libere(liste_inventaire.get_item_metadata(i)):
			liste_inventaire.get_item_metadata(i).queue_free()


func _inventaire_joueur_n_est_pas_null(joueur) -> bool:
	return joueur != null and joueur.inventaire_joueur != null


func _est_objet_pouvant_etre_libere(objet_potentiel : Variant) -> bool:
	return objet_potentiel != null and objet_potentiel.has_method("queue_free")
