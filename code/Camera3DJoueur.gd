extends Camera3D

##contient la reference au node du joueur
@onready var joueurCanard = get_node("../JoueurCanard")

##valeur d'un tour horizontal gauche complet en degre pour la rotation de la camera
const TOUR_HORIZONTAL_GAUCHE_COMPLET = 540
##valeur d'un tour horizontal droite complet en degre pour la rotation de la camera
const TOUR_HORIZONTAL_DROITE_COMPLET = -180
##valeur initiale de la rotation horizontale en degre pour la rotation de la camera
const ROTATION_HORIZONTALE_INITIALE = 180

##valeur de la rotation verticale de la camera
var rotationVerticaleCamera = 0
##valeur de la rotation horizontale de la camera
var rotationHorizontaleCamera = 180

func _ready():
	#isole la souris dans la fenetre
	Input.set_mouse_mode(2)


func _input(event):
	if event is InputEventMouseMotion:
		var directionMouvementSouris = event.relative

		actualiserValeurRotationCamera(directionMouvementSouris)

		ajusterPositionCamera()

		tournerCamera()


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


##permet de determiner la direction du mouvement vertical de la souris
func determinerDirectionMouvementVerticalSouris(event) -> int:
	var directionVerticaleSouris : int

	if event.relative.y > 0:
		print("souris descend")
	elif event.relative.y < 0:
		print("souris monte")
	
	return directionVerticaleSouris



##permet de determiner la direction du mouvement horizontal de la souris
func determinerDirectionMouvementHorizontalSouris(event) -> int:
	var directionHorizontaleSouris : int

	if event.relative.x > 0:
		print("souris vers la droite")
	elif event.relative.x < 0:
		print("souris vers la gauche")

	return directionHorizontaleSouris


##permet de tourner la camera en fonction de la direction du mouvement
##de la souris par le joueur
func tournerCamera() -> void:
	#application de la rotation a la camera
	rotation_degrees.x = rotationVerticaleCamera
	rotation_degrees.y = rotationHorizontaleCamera


##permet d'actualiser la valeur de la rotation de la camera
func actualiserValeurRotationCamera(directionMouvementSouris : Vector2) -> void:
	#actualisation de la valeur de rotation de la camera
	rotationVerticaleCamera -= directionMouvementSouris.y
	print("rotationVerticaleCamera = " + str(rotationVerticaleCamera))
	rotationHorizontaleCamera -= directionMouvementSouris.x
	print("rotationHorizontaleCamera = " + str(rotationHorizontaleCamera))
