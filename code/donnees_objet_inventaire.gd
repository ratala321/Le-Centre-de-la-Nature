class_name DonneesObjetInventaire
extends RefCounted

var nom_objet : String
var chemin_scene_objet : String


func _init(nom_objet_construction : String, chemin_scene_objet_construction : String):
	self.nom_objet = nom_objet_construction
	self.chemin_scene_objet = chemin_scene_objet_construction
	
