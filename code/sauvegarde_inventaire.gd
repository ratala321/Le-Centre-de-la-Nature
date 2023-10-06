class_name SauvegardeInventaire
extends Object


const PREFIXE_USER_DIR : String = "user://"
const SUFFIXE_SAUVEGARDE : String = ".txt"

## Le chemin partiel est le nom du fichier precede par le chemin de repertoires menant vers lui
## Exemple : repertoire/fichier | repertoire/sousRepertoire/fichier
static func sauvegarder_donnees_contenu_inventaire(donnees_a_sauvegarder : Dictionary,
		chemin_fichier_sauvegarde_partiel : String) -> void:
	var chemin_fichier_sauvegarde_complet : String = _initialiser_chemin_sauvegarde_complet(chemin_fichier_sauvegarde_partiel)
	
	var redacteur_fichier : FileAccess = _initialiser_redacteur_fichier(chemin_fichier_sauvegarde_partiel)
	if _ouverture_fichier_est_reussie(redacteur_fichier):
		_sauvegarder_donnees_a_sauvegarder(donnees_a_sauvegarder, redacteur_fichier)
		
		redacteur_fichier.close()


static func _initialiser_chemin_sauvegarde_complet(chemin_fichier_sauvegarde_partiel) -> String:
	return PREFIXE_USER_DIR + chemin_fichier_sauvegarde_partiel + SUFFIXE_SAUVEGARDE


static func _initialiser_redacteur_fichier(chemin_fichier_sauvegarde_partiel : String) -> FileAccess:
	var chemin_fichier_sauvegarde_complet : String =(
		PREFIXE_USER_DIR + chemin_fichier_sauvegarde_partiel + SUFFIXE_SAUVEGARDE
	)

	return FileAccess.open(chemin_fichier_sauvegarde_complet, FileAccess.WRITE)


static func _ouverture_fichier_est_reussie(redacteur_fichier : FileAccess) -> bool:
	return redacteur_fichier != null


static func _sauvegarder_donnees_a_sauvegarder(donnees_a_sauvegarder : Dictionary,
		redacteur_fichier : FileAccess) -> void:
	var donnees_a_sauvegardees_formattees : String = JSON.stringify(donnees_a_sauvegarder)
	
	redacteur_fichier.store_string(donnees_a_sauvegardees_formattees)
