class_name TransitionCamera3d
extends RefCounted


static func effectuer_transition_basique_camera_3d(initiale : Camera3D,
		destination : Camera3D, duree_transition : float = 1.0) -> void:
	var camera_de_transition : Camera3D = _initialiser_camera_de_transition(destination.get_tree())
	
	_ajuster_parametres_initiaux_camera_transition(camera_de_transition, initiale)
	
	camera_de_transition.make_current()
	
	await _deplacer_camera_transition_vers_destination(camera_de_transition, destination, duree_transition)
	
	destination.make_current()
	camera_de_transition.queue_free()


static func _initialiser_camera_de_transition(arbre_scene_en_cours : SceneTree) -> Camera3D:
	var scene_en_cours : Node = arbre_scene_en_cours.current_scene
	
	var camera_de_transition = Camera3D.new() 
	
	scene_en_cours.add_child(camera_de_transition)
	
	return camera_de_transition


## Permet d'ajuster les parametres initiaux de la camera de transition
## en se basant sur la camera initale de la transition.
static func _ajuster_parametres_initiaux_camera_transition(camera_de_transition : Camera3D,
		initiale : Camera3D) -> void:
	camera_de_transition.fov = initiale.fov
	
	camera_de_transition.cull_mask = initiale.cull_mask
	
	camera_de_transition.global_transform = initiale.global_transform


static func _deplacer_camera_transition_vers_destination(camera_de_transition : Camera3D,
		destination : Camera3D, duree_transition : float) -> void:
	var tween : Tween = destination.get_tree().current_scene.create_tween()
	
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_property(camera_de_transition, "global_transform",
		destination.global_transform, duree_transition)
		
	tween.tween_property(camera_de_transition, "fov", destination.fov, duree_transition)
	
	await tween.finished
