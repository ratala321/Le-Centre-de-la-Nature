class_name InteractionJoueur
extends RefCounted


var _joueur : JoueurCanard
func _init(joueur : JoueurCanard):
	self._joueur = joueur


## Destinee a etre lancee depuis le systeme d'animation
func effectuer_procedure_interaction_finale() -> void:
	var objets_en_collision : Array = _joueur.aire_interaction.get_overlapping_bodies()
	var i : int = 0

	while(
		_recherche_objet_interactif_est_en_cours(i, objets_en_collision.size()) and
		_n_est_pas_objet_interactif(objets_en_collision[i])
	):
		i += 1
	
	if _objet_interactif_a_ete_trouve(i, objets_en_collision.size()):
		_lancer_interaction_avec_objet_interactif(objets_en_collision[i])


func _recherche_objet_interactif_est_en_cours(compteur : int,
		nombre_objets_interactifs_potentiels : int) -> bool:
	return compteur < nombre_objets_interactifs_potentiels


func _n_est_pas_objet_interactif(objet_en_collision : Node) -> bool:
	#return not objet_en_collision.has_method("effectuer_interaction")
	return not objet_en_collision.has_node("RelaisInteractionJoueur")


func _objet_interactif_a_ete_trouve(index : int, nombre_objets_interactifs_potentiels : int) -> bool:
	return index < nombre_objets_interactifs_potentiels


func _lancer_interaction_avec_objet_interactif(objet_interactif : Node) -> void:
	#objet_interactif.effectuer_interaction(_joueur)
	objet_interactif.get_node("RelaisInteractionJoueur").utiliser_relais(_joueur)


## Destinee a etre lancee par le joueur
func effectuer_procedure_interaction_initiale() -> void:
	if _joueur_peut_interagir() and Input.is_action_just_pressed("interaction_joueur"):
		_jouer_animation_interaction()


func _joueur_peut_interagir() -> bool:
	return _joueur.est_au_sol() and _joueur_n_est_pas_deja_en_interaction()


func _joueur_n_est_pas_deja_en_interaction() -> bool:
	return not _joueur.machine_etat_animation.get_current_node() == NOM_ANIMATION_INTERACTION


const VITESSE_ANIMATION_INTERACTION : float = 1.5
const NOM_ANIMATION_INTERACTION : String = "Interact"
func _jouer_animation_interaction() -> void:
	_joueur.changer_etat_animation(NOM_ANIMATION_INTERACTION, VITESSE_ANIMATION_INTERACTION)
