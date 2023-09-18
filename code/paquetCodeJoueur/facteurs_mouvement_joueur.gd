class_name FacteursMouvementJoueur
extends RefCounted


## Utilise pour la rotation du joueur et de la camera.
var index_facteurs_rotation : int

var vitesse_esquive_joueur : int

## Utilise pour le deplacement du joueur dans une direction.
var direction_joueur : Vector3

func _init(index_facteurs_rotation_construction : int, vitesse_esquive_joueur_construction : int,
		direction_joueur_construction : Vector3):
	self.index_facteurs_rotation = index_facteurs_rotation_construction
	self.vitesse_esquive_joueur = vitesse_esquive_joueur_construction
	self.direction_joueur = direction_joueur_construction
