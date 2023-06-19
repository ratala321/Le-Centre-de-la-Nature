extends Node3D

##valeur de la sensibilite de la camera
@export var sensibiliteCamera : float = 1

##valeur d'un tour horizontal gauche complet en degre pour la rotation de la camera
const TOUR_HORIZONTAL_GAUCHE_COMPLET = 540
##valeur d'un tour horizontal droite complet en degre pour la rotation de la camera
const TOUR_HORIZONTAL_DROITE_COMPLET = -180
##valeur initiale de la rotation horizontale en degre pour la rotation de la camera
const ROTATION_HORIZONTALE_INITIALE = 180

#-------------------------------------------------------
#constantes liees a la limitation du mouvement de camera
#-------------------------------------------------------
##valeur maximale de la rotation verticale de la camera du joueur vers le haut
const ROTATION_VERTICALE_MAXIMALE_HAUT : float = 26
##valeur maximale de la rotation verticale de la camera du joueur vers le bas
const ROTATION_VERTICALE_MAXIMALE_BAS : float = -67

##valeur de la rotation verticale de la camera
var rotationVerticaleCamera : float = 0
##valeur de la rotation horizontale de la camera
var rotationHorizontaleCamera : float = 0


func _ready():
	#isole la souris dans la fenetre
	Input.set_mouse_mode(2)


func _input(event):
	#mouvement de la camera basee sur la direction de la souris
	if event is InputEventMouseMotion:
		var directionMouvementSouris = event.relative * sensibiliteCamera

		actualiserValeurRotationCamera(directionMouvementSouris)

		tournerCamera()


##permet de tourner la camera en fonction de la direction du mouvement
##de la souris par le joueur
func tournerCamera() -> void:
	#application de la rotation a la camera
	global_rotation_degrees.x = rotationVerticaleCamera
	global_rotation_degrees.y = rotationHorizontaleCamera


func actualiserValeurRotationCamera(directionMouvementSouris : Vector2) -> void:
	#actualisation de la valeur de rotation de la camera
	rotationVerticaleCamera += directionMouvementSouris.y
	rotationVerticaleCamera = clampf(rotationVerticaleCamera,
	ROTATION_VERTICALE_MAXIMALE_BAS, ROTATION_VERTICALE_MAXIMALE_HAUT)

	rotationHorizontaleCamera -= directionMouvementSouris.x

	#print("rotationVerticaleCamera = " + str(rotationVerticaleCamera))
	#print("rotationHorizontaleCamera = " + str(rotationHorizontaleCamera))


##permet de conserver la rotation de la camera malgre la rotation du joueur
func conserverRotationCamera(vecteurRotation) -> void:
	set_global_rotation_degrees(vecteurRotation)
