extends StaticBody2D

var id: String

func _on_Entrance_body_entered(body):
	if not Global.is_placement_mode and body.name == "Player":
		Global.in_house = id
		print("Entering house %s..." % id)
		get_tree().change_scene("res://game/HouseInterior.tscn")
