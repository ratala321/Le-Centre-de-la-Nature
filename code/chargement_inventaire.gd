class_name ChargementInventaire
extends Object


static func charger_donnees_contenu_inventaire(inventaire : AbstractInventaire) -> void:
	if _inventaire_n_est_pas_cree_proceduralement(inventaire):
		_effecuter_procedure_chargement_contenu_inventaire(inventaire)


static func _inventaire_n_est_pas_cree_proceduralement(inventaire : AbstractInventaire) -> bool:
	return inventaire.liste_inventaire.item_count == 0


static func _effecuter_procedure_chargement_contenu_inventaire(inventaire : AbstractInventaire) -> void:
	var donnees_contenu_inventaire : Array = _lire_donnees_contenu_inventaire(inventaire)

	_distribuer_objets_dans_inventaire(inventaire.liste_inventaire, donnees_contenu_inventaire)



static func _lire_donnees_contenu_inventaire(inventaire : AbstractInventaire) -> Array:
	var donnees_contenu_inventaire : Array

	if _fichier_sauvegarde_est_existant(inventaire.chemin_fichier_sauvegarde):
		donnees_contenu_inventaire = _lire_inventaire_sauvegarde(inventaire)
	elif _inventaire_par_defaut_est_existant(inventaire):
		donnees_contenu_inventaire = _lire_inventaire_par_defaut(inventaire)
	
	return donnees_contenu_inventaire


static func _fichier_sauvegarde_est_existant(chemin_fichier_sauvegarde : String) -> bool:
	return FileAccess.file_exists(chemin_fichier_sauvegarde)


static func _inventaire_par_defaut_est_existant(inventaire : AbstractInventaire) -> bool:
	return inventaire.inventaire_par_defaut != null and _inventaire_par_defaut_n_est_pas_vide(inventaire)


static func _inventaire_par_defaut_n_est_pas_vide(inventaire : AbstractInventaire) -> bool:
	return inventaire.inventaire_par_defaut.size() != 0


static func _lire_inventaire_sauvegarde(inventaire : AbstractInventaire) -> Array:
	var lecteur_fichier_sauvegarde : FileAccess =(
		FileAccess.open(inventaire.chemin_fichier_sauvegarde, FileAccess.READ))
	
	var donnees_objets_sauvegardes : Array = []
	while _lecture_fichier_est_incomplete(lecteur_fichier_sauvegarde):
		var donnees_objet_sauvegarde : DonneesObjetInventaire =(
			_lire_donnees_objet_sauvegarde(lecteur_fichier_sauvegarde))
		donnees_objets_sauvegardes.push_back(donnees_objet_sauvegarde)
	
	lecteur_fichier_sauvegarde.close()
	return donnees_objets_sauvegardes


static func _lire_inventaire_par_defaut(inventaire : AbstractInventaire) -> Array:
	var donnees_objets_par_defaut : Array = []

	for i in range(0, inventaire.inventaire_par_defaut.size(), 2):
		var donnees_objet_par_defaut : DonneesObjetInventaire =(
			_lire_donnees_objet_par_defaut(i, inventaire))
		donnees_objets_par_defaut.push_back(donnees_objet_par_defaut)
	
	return donnees_objets_par_defaut


static func _distribuer_objets_dans_inventaire(liste_inventaire : ItemList,
		donnees_objets : Array) -> void:
	for donnees_objet in donnees_objets:
		liste_inventaire.add_item(donnees_objet.nom_objet)

		var instance_objet : Variant =(
			_obtenir_metadata_objet_inventaire(donnees_objet.chemin_scene_objet))
		liste_inventaire.set_item_metadata(-1, instance_objet)


static func _obtenir_metadata_objet_inventaire(chemin_scene_objet : String) -> Variant:
	var scene_objet : PackedScene = load(chemin_scene_objet) as PackedScene

	return scene_objet.instantiate()


static func _lire_donnees_objet_sauvegarde(lecteur_fichier : FileAccess) -> DonneesObjetInventaire:
	var nom_objet : String = lecteur_fichier.get_line()
	var chemin_scene_objet : String = lecteur_fichier.get_line()

	return DonneesObjetInventaire.new(nom_objet, chemin_scene_objet)


static func _lecture_fichier_est_incomplete(lecteur_fichier : FileAccess) -> bool:
	return lecteur_fichier.get_position() < lecteur_fichier.get_length()


static func _lire_donnees_objet_par_defaut(index : int,
		inventaire : AbstractInventaire) -> DonneesObjetInventaire:
	var nom_objet : String = inventaire.inventaire_par_defaut[index].as_string()
	var chemin_scene_objet : String = inventaire.inventaire_par_defaut[index + 1].as_string()

	return DonneesObjetInventaire.new(nom_objet, chemin_scene_objet)
