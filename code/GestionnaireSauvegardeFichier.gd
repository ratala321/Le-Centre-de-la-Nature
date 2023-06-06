class_name abstractGestionnaireSauvgardeFichier extends Node

var donneesSauvegardees = {
	"prenom" : "Raphael",
	"nom" : "Talaia",
}

const EMPLACEMENT_FICHIER_SAUVEGARDE : String = "user://sauvegardeJoueur.txt"


func _notification(notif):
	if notif == Node.NOTIFICATION_WM_CLOSE_REQUEST:
		sauvergarderDonnees()

func _ready():
	chargerDonnees()


func sauvergarderDonnees() -> void:
	print(donneesSauvegardees)
	donneesSauvegardees.prenom = "Godot"
	donneesSauvegardees.nom = "Engine"

	var fichierDeSauvegarde = FileAccess.open(EMPLACEMENT_FICHIER_SAUVEGARDE, FileAccess.WRITE)

	var jsonSauvegarde = JSON.stringify(donneesSauvegardees)
	fichierDeSauvegarde.store_string(jsonSauvegarde)

	fichierDeSauvegarde.close()

	print("quitte!")


func chargerDonnees() -> void:
	if FileAccess.file_exists(EMPLACEMENT_FICHIER_SAUVEGARDE):
		var fichierDeSauvegarde = FileAccess.open(EMPLACEMENT_FICHIER_SAUVEGARDE, FileAccess.READ)

		while fichierDeSauvegarde.get_position() < fichierDeSauvegarde.get_length():
			donneesSauvegardees = JSON.parse_string(fichierDeSauvegarde.get_line())

		fichierDeSauvegarde.close()
		print(donneesSauvegardees)
