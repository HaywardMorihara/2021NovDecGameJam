extends Node2D

func _ready():
	if not Global.coming_from.empty():
		var houses := get_tree().get_nodes_in_group("houses")
		for house in houses:
			if house.id == Global.coming_from:
				$YSort/Player.global_position = house.get_node("Entrance").global_position + Vector2(0.0, house.get_node("Entrance/CollisionShape2D").shape.extents.y + 5)
		Global.coming_from = ""
