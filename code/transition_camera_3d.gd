class_name TransitionCamera3d
extends Node


static func effectuer_transition_basique_camera_3d(initiale : Camera3D,
		destination : Camera3D, duree_transition : float = 1.0) -> void:
	var camera_de_transition : Camera3D = initialiser_camera_de_transition(initiale.get_tree())
	
	ajuster_parametres_initiaux_camera_transition(camera_de_transition, initiale)
	
	camera_de_transition.current = true
	
	deplacer_camera_transition_vers_destination(camera_de_transition, destination, duree_transition)
	
	destination.current = true
	
	camera_de_transition.queue_free()


static func initialiser_camera_de_transition(arbre_scene_en_cours : SceneTree) -> Camera3D:
	var scene_en_cours : Node = arbre_scene_en_cours.current_scene
	
	var camera_de_transition = Camera3D.new() 
	
	scene_en_cours.add_child(camera_de_transition)
	
	return camera_de_transition


## Permet d'ajuster les parametres initiaux en se basant sur la camera initale de la transition
static func ajuster_parametres_initiaux_camera_transition(camera_de_transition : Camera3D,
		initiale : Camera3D) -> void:
	camera_de_transition.fov = initiale.fov
	
	camera_de_transition.cull_mask = initiale.cull_mask
	
	camera_de_transition.global_transform = initiale.global_transform


static func deplacer_camera_transition_vers_destination(camera_de_transition : Camera3D,
		destination : Camera3D, duree_transition : float) -> void:
	var tween : Tween = Tween.new()
	
	tween.interpolate_value(camera_de_transition.global_transform, destination.global_transform,
		destination.get_physics_process_delta_time(), duree_transition,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	
	tween.interpolate_value(camera_de_transition.fov, destination.fov,
		destination.get_physics_process_delta_time(), duree_transition, 
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	
	tween.play()
	
	await tween.finished
	
	tween.free()
