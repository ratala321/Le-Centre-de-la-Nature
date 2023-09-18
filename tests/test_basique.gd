extends GutTest

func test_allo():
	var scene_sac_graine : PackedScene = load("res://scenes/SacGraines.tscn")
	var instance_sac_graine = scene_sac_graine.instantiate()
	assert_eq(instance_sac_graine.est_outils_de_main(), 2, "FAIL TEST :c")
