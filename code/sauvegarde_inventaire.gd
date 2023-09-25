class_name SauvegardeInventaire
extends Object


static func sauvegarder_donnees_contenu_inventaire(donnees_a_sauvegarder : Array[DonneesObjetInventaire],
		chemin_fichier_sauvegarde : String) -> void:
	var redacteur_fichier : FileAccess = FileAccess.open(chemin_fichier_sauvegarde, FileAccess.WRITE)

	if _ouverture_fichier_est_reussie(redacteur_fichier):
		for i in range(0, donnees_a_sauvegarder.size()):
			_sauvegarder_donnee(redacteur_fichier, donnees_a_sauvegarder[i])

		redacteur_fichier.close()


static func _sauvegarder_donnee(redacteur_fichier : FileAccess,
		donnee_a_sauvegarder : DonneesObjetInventaire) -> void:
	redacteur_fichier.store_string(donnee_a_sauvegarder.nom_objet)
	redacteur_fichier.store_string("\n")
	redacteur_fichier.store_string(donnee_a_sauvegarder.chemin_scene_objet)
	redacteur_fichier.store_string("\n")


static func _ouverture_fichier_est_reussie(redacteur_fichier : FileAccess) -> bool:
	return redacteur_fichier != null
