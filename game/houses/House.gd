extends StaticBody2D

var id: String

func _on_Entrance_body_entered(body):
#	print("entering house body %s" % body.name)
	# I'm not sure why 'self.name != "House"' is necessary...
	if not Global.is_placement_mode and body.is_in_group("player"):
		Global.in_house = id
#		print("Entering house %s..." % id)
		get_tree().change_scene("res://game/HouseInterior.tscn")
