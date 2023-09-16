class_name FacteursMouvementJoueur
extends Object


## Utilise pour la rotation du joueur et de la camera.
var index_facteurs_rotation : int

var vitesse_esquive_joueur : int

## Utilise pour le deplacement du joueur dans une direction.
var vecteur_direction_joueur : Vector3

func _init(index_facteurs_rotation : int, vitesse_esquive_joueur : int,
		vecteur_direction_joueur : Vector3):
	self.index_facteurs_rotation = index_facteurs_rotation
	self.vitesse_esquive_joueur = vitesse_esquive_joueur
	self.vecteur_direction_joueur = vecteur_direction_joueur
