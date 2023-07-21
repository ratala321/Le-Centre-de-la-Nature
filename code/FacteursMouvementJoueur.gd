class_name FacteursMouvementJoueur extends Node

var vecteurDirectionJoueurBrut : Vector3
var vitesseEsquiveJoueur : int
var vecteurDirectionJoueur : Vector3

func _init(vecteurDirectionJoueurBrut : Vector3,
 vitesseEsquiveJoueur : int, vecteurDirectionJoueur : Vector3):
	_initialiserFacteursMouvementJoueur(vecteurDirectionJoueurBrut,
		vitesseEsquiveJoueur, vecteurDirectionJoueur)


func _initialiserFacteursMouvementJoueur(vecteurDirectionJoueurBrut : Vector3,
 vitesseEsquiveJoueur : int, vecteurDirectionJoueur : Vector3) -> void:
	self.vecteurDirectionJoueurBrut = vecteurDirectionJoueurBrut
	self.vitesseEsquiveJoueur = vitesseEsquiveJoueur
	self.vecteurDirectionJoueur = vecteurDirectionJoueur
