extends GutTest


const CHEMIN_SAUVEGARDE_TEST_PARTIEL : String = "tests/test_sauvegarde_inventaire"
const CHEMIN_SAUVEGARDE_TEST_COMPLET : String =(
	SauvegardeInventaire.PREFIXE_USER_DIR + CHEMIN_SAUVEGARDE_TEST_PARTIEL +
	SauvegardeInventaire.SUFFIXE_SAUVEGARDE
)
var donnees_test : Array[DonneesObjetInventaire] = []


func before_all():
	var dir_access = DirAccess.open("user://")
	dir_access.make_dir("tests")


func before_each():
	donnees_test.push_back(DonneesObjetInventaire.new("nom de test", "faux chemin de test"))
	donnees_test.push_back(DonneesObjetInventaire.new("nom alternatif", "vrai chemin test"))
	
	SauvegardeInventaire.sauvegarder_donnees_contenu_inventaire(donnees_test, CHEMIN_SAUVEGARDE_TEST_PARTIEL)


func after_each():
	donnees_test.clear()


func after_all():
	DirAccess.remove_absolute(CHEMIN_SAUVEGARDE_TEST_COMPLET)


func test_presence_fichier_sauvegarde():
	assert_eq(FileAccess.file_exists(CHEMIN_SAUVEGARDE_TEST_COMPLET), true)


const CONTENU_FICHIER_ATTENDU : String =(
	"nom de test\nfaux chemin de test\nnom alternatif\nvrai chemin test\n"
)
func test_contenu_fichier_sauvegarde():
	var lecteur_fichier : FileAccess = FileAccess.open(CHEMIN_SAUVEGARDE_TEST_COMPLET, FileAccess.READ)

	var contenu_fichier : String = lecteur_fichier.get_as_text()

	assert_eq(contenu_fichier, CONTENU_FICHIER_ATTENDU)


func test_sauvegarde_chemin_invalide():
	SauvegardeInventaire.sauvegarder_donnees_contenu_inventaire(donnees_test, "user://INVALIDE/invalide.txt")
	
	var _lecteur_fichier : FileAccess = FileAccess.open(CHEMIN_SAUVEGARDE_TEST_COMPLET, FileAccess.READ)

	pass_test("Aucune erreur, reussite")


func test_sauvegarde_donnees_vides():
	donnees_test.clear()
	SauvegardeInventaire.sauvegarder_donnees_contenu_inventaire(donnees_test, CHEMIN_SAUVEGARDE_TEST_PARTIEL)

	var lecteur_fichier : FileAccess = FileAccess.open(CHEMIN_SAUVEGARDE_TEST_COMPLET, FileAccess.READ)

	var contenu_fichier : String = lecteur_fichier.get_as_text()

	assert_eq(contenu_fichier, "")
