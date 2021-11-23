extends Area2D

func _on_Exit_body_entered(body):
	if body.name == "Player":
		Global.coming_from = Global.in_house
		Global.in_house = ""
		get_tree().change_scene("res://game/Game.tscn")
