extends Camera3D

##contient la reference au node du joueur
@onready var joueurCanard = get_node("../JoueurCanard")

func _physics_process(delta):
	ajusterPositionCamera()


##permet d'ajuster la position de la camera par rapport a la position du joueur
func ajusterPositionCamera() -> void:
	position = joueurCanard.position - Vector3(0,-3,5)
	
