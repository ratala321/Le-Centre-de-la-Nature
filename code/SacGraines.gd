extends RigidBody3D

const espaceFertileGroupe : String = "EspacePlante"

var aireDetectionSolFertile : Area3D

func _ready():
	aireDetectionSolFertile = $AireDetectetionSolFertile
	$IntervalleReperageEspacesFertiles.connect("timeout", detecterEspaceFertile)


func detecterEspaceFertile():
	var airesEnCollision = aireDetectionSolFertile.get_overlapping_areas()
	
	var i : int = 0
	var nEstPasDetecte = true
	while detectionEstIncomplete(i, airesEnCollision.size(), nEstPasDetecte):
		if(estEspaceFertile(airesEnCollision[i])):
			nEstPasDetecte = false
			print("le sac peut planter")
			#procedure aireEnCollision[i].procedure
		i += 1


func detectionEstIncomplete(compteurBoucle : int,
 nombreAiresEnCollision : int, nEstPasDetecte : bool) -> bool:
	return compteurBoucle < nombreAiresEnCollision and nEstPasDetecte


func estEspaceFertile(aireEnCollision) -> bool:
	return aireEnCollision.is_in_group(espaceFertileGroupe)
