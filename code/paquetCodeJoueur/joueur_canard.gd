class_name JoueurCanard
extends CharacterBody3D


@export var camera_joueur : Camera3D


var detient_objet_en_main_droite : bool = false
var detient_objet_en_main_gauche : bool = false

var vitesse_animation_actuelle : float = VITESSE_ANIMATION_INITIALE


@onready var _raycast_joueur_sol : RayCast3D = get_node("RayEstAuSol") as RayCast3D
@onready var animation_joueur : AnimationPlayer =(
	get_node("KayKit_AnimatedCharacter_v13/AnimationPlayer") as AnimationPlayer
)
@onready var controleur_animation_joueur : AnimationTree = %AnimationTree
@onready var machine_etat_animation : AnimationNodeStateMachinePlayback =(
	controleur_animation_joueur.get("parameters/playback")
)
@onready var aire_interaction : Area3D = get_node("AireInteraction") as Area3D
@onready var axe_rotation_camera : Node3D = get_node("AxeRotationCamera") as Node3D
@onready var audio_joueur : AudioStreamPlayer = get_node("AudioStreamPlayer") as AudioStreamPlayer
@onready var chronometre_esquive : Timer = get_node("ChronometreEsquive") as Timer
@onready var inventaire_joueur : AbstractInventaire = get_node("InventaireJoueur") as AbstractInventaire
@onready var main_droite_joueur : BoneAttachment3D =(
	get_node("KayKit_AnimatedCharacter_v13/KayKit Animated Character2/Skeleton3D/MainEmplacementDroit") as BoneAttachment3D
)
@onready var main_gauche_joueur : BoneAttachment3D =(
	get_node("KayKit_AnimatedCharacter_v13/KayKit Animated Character2/Skeleton3D/MainEmplacementGauche") as BoneAttachment3D
)


var _interaction_joueur : InteractionJoueur
var _affichage_inventaire_joueur : AffichageInventaireJoueur
var _mouvement_joueur : MouvementJoueur
var _entree_mouvement_joueur : EntreeMouvementJoueur
func _init():
	_interaction_joueur = InteractionJoueur.new(self)
	_affichage_inventaire_joueur = AffichageInventaireJoueur.new(self);
	_mouvement_joueur = MouvementJoueur.new(self);
	_entree_mouvement_joueur = EntreeMouvementJoueur.new(self);


func _physics_process(delta):
	progresser_animation_joueur(delta)
	
	_effectuer_procedure_mouvement_joueur(delta)

	_affichage_inventaire_joueur.effectuer_procedure_affichage_inventaire()

	_interaction_joueur.effectuer_procedure_interaction_initiale()


func progresser_animation_joueur(delta) -> void:
		controleur_animation_joueur.advance(delta * vitesse_animation_actuelle)


func _effectuer_procedure_mouvement_joueur(delta) -> void:
	var facteurs_mouvement_joueur : FacteursMouvementJoueur =(
		_entree_mouvement_joueur.saisir_entree_mouvement_joueur()
	)
	
	_mouvement_joueur.effectuer_procedure_appplication_mouvement(delta, facteurs_mouvement_joueur)


const VITESSE_ANIMATION_INITIALE : int = 1
func reinitialiser_vitesse_animation() -> void:
	vitesse_animation_actuelle = VITESSE_ANIMATION_INITIALE


func est_au_sol() -> bool:
	return _raycast_joueur_sol.is_colliding()


## Destinee a etre appelee depuis l'animation d'interaction du joueur
func lancer_procedure_interaction_finale() -> void:
	_interaction_joueur.effectuer_procedure_interaction_finale()


var _permission_mouvement : bool = true
func peut_se_mouvoir() -> bool:
	return _permission_mouvement


func arreter_mouvement() -> void:
	_permission_mouvement = false
	self.velocity = Vector3.ZERO


func relancer_mouvement() -> void:
	_permission_mouvement = true


func niveau_du_joueur_est_en_pause() -> bool:
	return get_tree().paused


func liberer_main_droite(objet_exception : Variant) -> void:
	var objets_main_droite : Array[Node] = main_droite_joueur.get_children()

	for objet_main_droite in objets_main_droite:
		if(
			objet_main_droite.has_method("effectuer_procedure_retrait_main_joueur") and 
			objet_main_droite != objet_exception
		):
			objet_main_droite.effectuer_procedure_retrait_main_joueur(self)


func liberer_main_gauche(objet_exception : Variant) -> void:
	var objets_main_gauche : Array[Node] = main_gauche_joueur.get_children()

	for objet_main_gauche in objets_main_gauche:
		if(
			objet_main_gauche.has_method("effectuer_procedure_retrait_main_joueur") and 
			objet_main_gauche != objet_exception
		):
			objet_main_gauche.effectuer_procedure_retrait_main_joueur(self)


## non implementee pour le moment, car aucun objet a deux mains dans le jeu pour l'instant
func liberer_deux_mains(_objet_exception : Variant) -> void:
	pass


## Permet de travel vers un etat appartenant a l'animation du joueur
func changer_etat_animation(nom_animation : String, vitesse_animation : float = 1 ) -> void:
	if animation_joueur.has_animation(nom_animation):
		vitesse_animation_actuelle = vitesse_animation
		
		machine_etat_animation.travel(nom_animation)
		machine_etat_animation.next()


## Destine a etre appele depuis un Collectionnable, permet de le collecter
func collecter_objet(collectionnable : Collectionnable) -> void:
	inventaire_joueur.ajouter_collectionnable_a_inventaire(collectionnable)
	
	if not collectionnable.is_queued_for_deletion():
		collectionnable.lancer_processus_retrait_self_du_scene_tree()
