extends GutTest

const planteTest = preload("res://scenes/plantesScenes/BleScene.tscn")


static var solTest
func _ready():
	solTest = get_node("../../SolFertile")


func lancerTests():
	var espaceTest = _miseEnPlaceTests()
	
	_testContientPrevisualisationInitial(espaceTest)
	
	_testContientPrevisualisationApresAjout(espaceTest)
	
	_testRetirerPrevisualisationNonFonctionnel(espaceTest)
	
	_testRetirerPrevisualisationFonctionnel(espaceTest)


func _miseEnPlaceTests():
	var conteneur = solTest.get_node("ConteneurEspacePlante")
	return conteneur.get_node("EspacePlante0")


func _testContientPrevisualisationInitial(espaceTest) -> void:
	assert_eq(false, espaceTest.contientUnePrevisualisation,
	"ERREUR, _testContientPrevisualisationInitial:TestEspacePlante.gd " +
	"contientUnePrevisualisation devrait etre faux intialement")


func _testContientPrevisualisationApresAjout(espaceTest) -> void:
	espaceTest.previsualiserPlante(planteTest)
	assert_eq(true, espaceTest.contientUnePrevisualisation,
	"ERREUR, _testContientPrevisualisationApresAjout:TestEspacePlante.gd " +
	"contientUnePrevisualisation devrait etre vrai apres l'ajout d'une previsualisation")


func _testRetirerPrevisualisationNonFonctionnel(espaceTest) -> void:
	var aire = Area3D.new()
	espaceTest._retirerPrevisualisationApresSortieJoueur(aire)
	assert_eq(true, espaceTest.contientUnePrevisualisation,
	"ERREUR, _testRetirerPrevisualisationNonFonctionnel:TestEspacePlante.gd " +
	"contientUnePrevisualisation devrait rester inchangee lors de la sortie d'une AREA3D quelconque")


func _testRetirerPrevisualisationFonctionnel(espaceTest) -> void:
	var aire : Area3D = _preparerTestRetirerPrevisualisationFonctionnel()
	
	espaceTest._retirerPrevisualisationApresSortieJoueur(aire)
	assert_eq(false, espaceTest.contientUnePrevisualisation,
	"ERREUR, _testRetirerPrevisualisation:TestEspacePlante.gd " +
	"contientUnePrevisualisation devrait etre faux apres avoir retire previsualisation")


func _preparerTestRetirerPrevisualisationFonctionnel() -> Area3D:
	const SacGraineScene = preload("res://scenes/SacGraines.tscn")
	var sacGraine = SacGraineScene.instantiate()
	add_child(sacGraine)
	return sacGraine.get_node("AireDetectionEspacePlante")
