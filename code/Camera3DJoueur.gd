extends Camera3D

@onready var joueurCanard = get_node("../JoueurCanard")

func _ready():
	joueurCanard.rotation_joueur_.connect(ajusterPositionCamera_rotation_joueur)

func ajusterPositionCamera_rotation_joueur(directionJoueur : Vector3) -> void:
	position = joueurCanard.position - Vector3(0,-3,5)
	
