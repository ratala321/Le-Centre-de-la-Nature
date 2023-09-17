class_name AffichageInventaireJoueur
extends Reference


var _joueur : JoueurCanard
func _init(joueur : JoueurCanard):
	self._joueur = joueur


func effectuer_procedure_affichage_inventaire() -> void:
	if Input.is_action_just_pressed("inventaire_joueur") and _affichage_inventaire_est_permis():
		_afficher_inventaire_joueur()


func _affichage_inventaire_est_permis() -> bool:
	return(
		_etat_niveau_permet_affichage_inventaire() and
		_etat_joueur_permet_affichage_inventaire()
	)


func _etat_niveau_permet_affichage_inventaire() -> bool:
	return not _joueur.niveau_du_joueur_est_en_pause()


func _etat_joueur_permet_affichage_inventaire() -> bool:
	return _joueur.est_au_sol() and _joueur.peut_se_mouvoir()


func _afficher_inventaire_joueur() -> void:
	inventaire_joueur : AbstractInventaire = _joueur.inventaire_joueur
	scene_en_cours : SceneTree = _joueur.get_tree()
	inventaire_joueur.afficher_interface(scene_en_cours)
