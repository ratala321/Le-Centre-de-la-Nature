class_name ChargementInventaire
extends Object


static func charger_donnees_contenu_inventaire(inventaire : AbstractInventaire) -> void:
	if _inventaire_n_est_pas_cree_proceduralement(inventaire):
		_effecuter_procedure_chargement_contenu_inventaire(inventaire)


static func _inventaire_n_est_pas_cree_proceduralement(inventaire : AbstractInventaire) -> bool:
	return inventaire.liste_inventaire.item_count == 0


static func _effecuter_procedure_chargement_contenu_inventaire(inventaire : AbstractInventaire) -> void:
	var donnees_contenu_inventaire : Array =(
			_lire_donnees_contenu_inventaire(inventaire)
	)

	_distribuer_objets_dans_inventaire(inventaire.liste_inventaire, donnees_contenu_inventaire)



static func _lire_donnees_contenu_inventaire(inventaire : AbstractInventaire) -> Array:
	var donnees_contenu_inventaire : Array

	if _fichier_sauvegarde_est_existant(inventaire.chemin_fichier_sauvegarde_partiel):
		donnees_contenu_inventaire = _lire_inventaire_sauvegarde(inventaire)
	elif _inventaire_par_defaut_est_existant(inventaire):
		donnees_contenu_inventaire = _lire_inventaire_par_defaut(inventaire)
	
	return donnees_contenu_inventaire


static func _fichier_sauvegarde_est_existant(chemin_fichier_sauvegarde_partiel : String) -> bool:
	var chemin_sauvegarde_complet =(
		SauvegardeInventaire.PREFIXE_USER_DIR + chemin_fichier_sauvegarde_partiel + SauvegardeInventaire.SUFFIXE_SAUVEGARDE
	)

	return FileAccess.file_exists(chemin_sauvegarde_complet)


static func _inventaire_par_defaut_est_existant(inventaire : AbstractInventaire) -> bool:
	return inventaire.inventaire_par_defaut != null and _inventaire_par_defaut_n_est_pas_vide(inventaire)


static func _inventaire_par_defaut_n_est_pas_vide(inventaire : AbstractInventaire) -> bool:
	return inventaire.inventaire_par_defaut.size() != 0


static func _lire_inventaire_sauvegarde(inventaire : AbstractInventaire) -> Array:
	var lecteur_fichier_sauvegarde : FileAccess =(
		_initialiser_lecteur_fichier_sauvegarde(inventaire.chemin_fichier_sauvegarde_partiel)
	)
	
	var contenu_fichier_inventaire : String = ""
	
	while _lecture_fichier_est_incomplete(lecteur_fichier_sauvegarde):
		contenu_fichier_inventaire += lecteur_fichier_sauvegarde.get_line()
	
	lecteur_fichier_sauvegarde.close()
	
	var contenu_fichier_inventaire_parse : Dictionary = JSON.parse_string(contenu_fichier_inventaire)
	
	return contenu_fichier_inventaire_parse.get("objets_sauvegardes")


static func _lire_inventaire_par_defaut(inventaire : AbstractInventaire) -> Array:
	var donnees_objets_par_defaut : Array = []

	for i in range(0, inventaire.inventaire_par_defaut.size()):
		var donnees_objet_par_defaut : Dictionary = inventaire.inventaire_par_defaut[i]
		donnees_objets_par_defaut.push_back(donnees_objet_par_defaut)
	
	return donnees_objets_par_defaut


static func _distribuer_objets_dans_inventaire(liste_inventaire : ItemList,
		donnees_objets : Array) -> void:
	for donnees_objet in donnees_objets:
		var chemin_scene_objet : String = donnees_objet.get("chemin_scene_objet")

		var instance_objet : Node = _initialiser_instance_objet_inventaire(chemin_scene_objet)
		
		_charger_donnees_sauvegardees_dans_objet_inventaire(instance_objet,
			donnees_objet.get("donnees_objet_inventaire"))
		
		var nom_dans_inventaire : String = donnees_objet.get("nom_dans_inventaire")
		
		liste_inventaire.add_item(nom_dans_inventaire)
		liste_inventaire.set_item_metadata(-1, instance_objet)


static func _lecture_fichier_est_incomplete(lecteur_fichier : FileAccess) -> bool:
	return lecteur_fichier.get_position() < lecteur_fichier.get_length()


static func _initialiser_lecteur_fichier_sauvegarde(chemin_fichier_sauvegarde_partiel : String) -> FileAccess:
	var chemin_fichier_sauvegarde_complet : String =(
		SauvegardeInventaire.PREFIXE_USER_DIR + chemin_fichier_sauvegarde_partiel +
		SauvegardeInventaire.SUFFIXE_SAUVEGARDE
	)

	return FileAccess.open(chemin_fichier_sauvegarde_complet, FileAccess.READ)


## Retourne l'instance associee a la scene de l'objet. Dans le cas ou le
## chemin de la scene est invalide, retourne null.
static func _initialiser_instance_objet_inventaire(chemin_scene_objet) -> Node:
	var scene_objet : PackedScene = load(chemin_scene_objet)

	var instance_objet : Node 

	if scene_objet != null:
		instance_objet = scene_objet.instantiate()
	else:
		instance_objet = null

	return instance_objet


static func _charger_donnees_sauvegardees_dans_objet_inventaire(instance_objet : Node,
		donnees_sauvegardees_instance : Dictionary) -> void:
	if (
			instance_objet != null and 
			instance_objet.has_method("charger_dictionnaire_donnees_sauvegardees")
	):
		instance_objet.charger_dictionnaire_donnees_sauvegardees(donnees_sauvegardees_instance)
