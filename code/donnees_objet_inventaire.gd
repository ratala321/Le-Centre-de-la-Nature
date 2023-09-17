class_name DonneesObjetInventaire
extends RefCounted

var nom_objet : String
var chemin_scene_objet : String


func _init(nom_objet : String, chemin_scene_objet : String):
	self.nom_objet = nom_objet
	self.chemin_scene_objet = chemin_scene_objet
	
