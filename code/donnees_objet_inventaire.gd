class_name DonneesObjetInventaire
extends RefCounted

var nom_objet : String
var chemin_scene_objet : String


func _init(nom_objet_init : String, chemin_scene_objet_init : String):
	self.nom_objet = nom_objet_init
	self.chemin_scene_objet = chemin_scene_objet_init
	
