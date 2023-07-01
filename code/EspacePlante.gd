extends Area3D

var contientUnePrevisualisation : bool = false

func previsualiserPlante(planteScene : PackedScene):
	if not contientUnePrevisualisation:
		contientUnePrevisualisation = true
		var plante = planteScene.instantiate()
		ajouterPrevisualisationPlante(plante)


func ajouterPrevisualisationPlante(plante):
		plante.position = $PositionPlante.position
		add_child(plante)
		print("ajout previsualisation plante")

