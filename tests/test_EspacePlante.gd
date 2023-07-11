extends GutTest

static var EspacePlante = load("res://code/EspacePlante.gd")
static var espaceTest = EspacePlante.new()

func test_contientUnePrevisualisationInitial():
	var resultat : bool = espaceTest.contientUnePrevisualisation
	assert_eq(resultat, false,
	 "Le booleen contientUnePrevisualisation devrait etre faux intialement")
