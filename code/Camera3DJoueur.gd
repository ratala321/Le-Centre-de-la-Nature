extends Camera3D

##contient la reference au node du joueur
@onready var joueurCanard = get_node("../JoueurCanard")

func _ready():
	#isole la souris dans la fenetre
	Input.set_mouse_mode(2)


func _input(event):
	if event is InputEventMouseMotion:
		var directionMouvementSouris : Vector2 = determinerDirectionMouvementSouris(event)
		#tournerCamera(directionMouvementSouris)


func _physics_process(delta):
	ajusterPositionCamera()


##permet d'ajuster la position de la camera par rapport a la position du joueur
func ajusterPositionCamera() -> void:
	position = joueurCanard.position - Vector3(0,-3,5)
	

##permet de determiner la direction du mouvement de la souris
##par le joueur
func determinerDirectionMouvementSouris(event) -> Vector2:
	var directionMouvementSouris : Vector2
	directionMouvementSouris.y = determinerDirectionMouvementVerticalSouris(event)
	directionMouvementSouris.x = determinerDirectionMouvementHorizontalSouris(event)

	return directionMouvementSouris


##?
func determinerDirectionMouvementVerticalSouris(event) -> int:
	var directionVerticaleSouris : int

	if event.relative.y > 0:
		print("souris descend")
	elif event.relative.y < 0:
		print("souris monte")
	
	return directionVerticaleSouris



##?
func determinerDirectionMouvementHorizontalSouris(event) -> int:
	var directionHorizontaleSouris : int

	if event.relative.x > 0:
		print("souris vers la droite")
	elif event.relative.x < 0:
		print("souris vers la gauche")

	return directionHorizontaleSouris


##permet de tourner la camera en fonction de la direction du mouvement
##de la souris par le joueur
func tournerCamera(directionMouvementSouris : Vector2) -> void:
	pass
