extends GutTest

func test_allo():
	var sceneSac : PackedScene = load("res://scenes/SacGraines.tscn")
	var instanceSac = sceneSac.instantiate()
	assert_eq(instanceSac.EstObjetDeMain(),2, "FAIL TEST :c")
