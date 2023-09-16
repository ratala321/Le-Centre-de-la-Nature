class_name AbstractOutils
extends Node3D


var _est_en_main : bool = false


func effectuer_procedure_selection_depuis_inventaire(JoueurCanard joueur) -> void:
	print("PROCEDURE SELECTION OUTILS")
	if est_en_main:
		_retirer_outils_dans_main(joueur)
	else:
		-ajouter_outils_dans_main(joueur)


func _retirer_outils_dans_main(joueur : JoueurCanard) -> void:
	if _est_outils_de_main_droite():
		_retirer_outils_dans_main_droite(joueur)

	if _est_outils_de_main_gauche():
		_retirer_outils_dans_main_gauche(joueur)


func _ajouter_outils_dans_main(joueur) -> void:
	if _est_outils_de_main_droite():
		_ajouter_outils_dans_main_droite(joueur)

	if _est_outils_de_main_gauche():
		_ajouter_outils_dans_main_gauche(joueur)


const VALEUR_OUTILS_MAIN_DROITE : int = 1
func _est_outils_de_main_droite() -> bool:
	return self.est_outils_de_main() == VALEUR_OUTILS_MAIN_DROITE


const VALEUR_OUTILS_MAIN_GAUCHE : int = 2
func _est_outils_de_main_gauche() -> bool:
	return self.est_outils_de_main() == VALEUR_OUTILS_MAIN_GAUCHE


func _ajouter_outils_dans_main_droite(joueur : JoueurCanard) -> void:
	print("ajouter outils dans main droite")
	_retirer_outils_deja_present_main_droite(joueur)

	joueur.main_droite_joueur.add_child(self)
	joueur.objet_main_droite_en_main = true
	_est_en_main = true


func _retirer_outils_dans_main_droite(joueur : JoueurCanard) -> void:
	print("retirer outils main droite")
	joueur.main_droite_joueur.remove_child(self)
	joueur.objet_main_droite_en_main = false
	_est_en_main = false


func _ajouter_outils_dans_main_gauche(joueur : JoueurCanard) -> void:
	print("ajouter outils main gauche")
	_retirer_outils_deja_present_main_gauche(joueur)

	joueur.main_gauche_joueur.add_child(self)
	joueur.objet_main_gauche_en_main = true
	_est_en_main = true


func _retirer_outils_dans_main_gauche(joueur : JoueurCanard) -> void:
	print("retirer outils main gauche")
	joueur.main_gauche_joueur.remove_child(self)
	joueur.objet_main_gauche_en_main = false
	_est_en_main = false


func _retirer_outils_deja_present_main_droite(joueur : JoueurCanard) -> void:
	if joueur.objet_main_droite_en_main:
		# TODO le faire directement dans joueur ?
		_retirer_outils_dans_main_droite(joueur)


func _retirer_outils_deja_present_main_gauche(joueur : JoueurCanard) -> void:
	if joueur.objet_main_gauche_en_main:
		# TODO le faire directement dans joueur ?
		_retirer_outils_dans_main_gauche(joueur)


#---------------------------------------------------------------
# Permet d'effectuer l'action principale associee a un outils.
# Par exemple, une pelle dont son action est de creuser.
# abstract effecter_action_principale(delta) -> void

# Permet de determiner dans quelle main, gauche ou droite, un outils s'utilise.
# retourne 1 si l'objet est de main droite, ou 2 si l'objet est de main gauche.
# abstract est_outils_de_main() -> int: