extends AnimationPlayer


@export var _joueur : JoueurCanard


func transition_idle_walk() -> bool:
	return _joueur.est_au_sol() and _joueur.velocity != Vector3.ZERO


func transition_vers_jump() -> bool:
	return not _joueur.est_au_sol()


