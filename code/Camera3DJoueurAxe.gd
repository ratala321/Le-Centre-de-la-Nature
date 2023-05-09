extends Node3D

##valeur d'un tour horizontal gauche complet en degre pour la rotation de la camera
const TOUR_HORIZONTAL_GAUCHE_COMPLET = 540
##valeur d'un tour horizontal droite complet en degre pour la rotation de la camera
const TOUR_HORIZONTAL_DROITE_COMPLET = -180
##valeur initiale de la rotation horizontale en degre pour la rotation de la camera
const ROTATION_HORIZONTALE_INITIALE = 180

##valeur de la rotation verticale de la camera
var rotationVerticaleCamera = 0
##valeur de la rotation horizontale de la camera
var rotationHorizontaleCamera = 0
#?
var vecteurRotationCamera


func _ready():
	#isole la souris dans la fenetre
	Input.set_mouse_mode(2)


func _input(event):
	if event is InputEventMouseMotion:
		var directionMouvementSouris = event.relative

		actualiserValeurRotationCamera(directionMouvementSouris)

		tournerCamera()


##permet de tourner la camera en fonction de la direction du mouvement
##de la souris par le joueur
func tournerCamera() -> void:
	#application de la rotation a la camera
	rotation_degrees.x = rotationVerticaleCamera
	rotation_degrees.y = rotationHorizontaleCamera
	vecteurRotationCamera = get_global_rotation_degrees()


##permet d'actualiser la valeur de la rotation de la camera
func actualiserValeurRotationCamera(directionMouvementSouris : Vector2) -> void:
	#actualisation de la valeur de rotation de la camera
	rotationVerticaleCamera += directionMouvementSouris.y
	print("rotationVerticaleCamera = " + str(rotationVerticaleCamera))
	rotationHorizontaleCamera -= directionMouvementSouris.x
	print("rotationHorizontaleCamera = " + str(rotationHorizontaleCamera))


##permet de tourner la camera lorsque le joueur est en mouvement?
func tournerCameraMouvementJoueur(vecteurRotation : Vector3) -> void:
	set_global_rotation_degrees(vecteurRotationCamera)
	#set_rotation(-vecteurRotation)
	#rotationVerticaleCamera = rotation_degrees.x
	#rotationHorizontaleCamera = rotation_degrees.y
