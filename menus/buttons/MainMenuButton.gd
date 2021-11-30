extends Button

func _on_MainMenuButton_pressed():
	Global.in_house = ""
	Global.is_placement_mode = false
	Global.is_removal_mode = false
	Global.is_house_placement_mode = false
	Global.just_started = true
	get_tree().change_scene("res://menus/MainMenu.tscn")
