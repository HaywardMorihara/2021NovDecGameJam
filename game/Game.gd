extends Node2D

func _ready():
	if not Global.coming_from.empty():
		var houses := get_tree().get_nodes_in_group("houses")
		for house in houses:
			if house.id == Global.coming_from:
				$YSort/Player.global_position = house.get_node("Entrance").global_position + Vector2(0.0, 20.0)
				break
		Global.coming_from = ""
