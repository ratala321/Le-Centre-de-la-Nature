class_name InteractionJoueur
extends Reference


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


func _n_est_pas_objet_interactif(objet_en_collision) -> bool:
	return not objet_en_collision.has_method("effectuer_interaction")


func _objet_interactif_a_ete_trouve(index : int, nombre_objets_interactifs_potentiels : int) -> bool:
	return index < nombre_objets_interactifs_potentiels


func _lancer_interaction_avec_objet_interactif(objet_interactif) -> void:
	objet_interactif.effectuer_interaction(_joueur)


## Destinee a etre lancee par le joueur
func effectuer_procedure_interaction_initiale() -> void:
	if _joueur_peut_interagir():
		_jouer_animation_interaction()


func _joueur_peut_interagir() -> bool:
	return _joueur.est_au_sol() and Input.is_action_pressed("interaction_joueur")


const VITESSE_ANIMATION_INTERACTION : float = 1.5
const NOM_ANIMATION_INTERACTION : String = "Interact"
func _jouer_animation_interaction() -> void:
	var animation_joueur : AnimationPlayer = _joueur.animation_joueur

	animation_joueur.speed_scale = VITESSE_ANIMATION_INTERACTION
	animation_joueur.play(NOM_ANIMATION_INTERACTION)
