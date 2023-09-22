extends GutTest


var instance_joueur : JoueurCanard
var instance_epee_joueur : AbstractOutils


func before_each():
	var scene_joueur : PackedScene = load("res://scenes/JoueurCanard.tscn")
	var scene_epee_joueur : PackedScene = load("res://scenes/EpeeJoueur.tscn")
	
	instance_joueur = scene_joueur.instantiate()
	instance_epee_joueur = scene_epee_joueur.instantiate()


func after_each():
	var instances_a_liberer : Array = [instance_joueur, instance_epee_joueur]
	
	for instance_a_liberer in instances_a_liberer:
		if instance_a_liberer != null:
			instance_a_liberer.queue_free()


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
