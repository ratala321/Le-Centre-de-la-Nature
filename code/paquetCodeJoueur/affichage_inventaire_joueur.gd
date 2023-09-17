class_name AffichageInventaireJoueur
extends Object


var _joueur : JoueurCanard
func _init(joueur : JoueurCanard):
	self._joueur = joueur


func effectuer_affichage_inventaire_joueur() -> void:
	if Input.is_action_just_pressed("inventaire_joueur") and affichage_inventaire_est_permis():
		inventaire_joueur : AbstractInventaire = _joueur.inventaire_joueur
		scene_en_cours : SceneTree = _joueur.get_tree()
		inventaire_joueur.afficher_interface(scene_en_cours)


func affichage_inventaire_est_permis() -> bool:
	return(
		_etat_niveau_permet_affichage_inventaire() and
		_etat_joueur_permet_affichage_inventaire()
	)


func _etat_niveau_permet_affichage_inventaire() -> bool:
	return not _joueur.niveau_du_joueur_est_en_pause()


func _etat_joueur_permet_affichage_inventaire() -> bool:
	return _joueur.est_au_sol() and _joueur.peut_se_mouvoir()


