extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not Global.is_placement_mode:
		$HUDLine3.text = "'E' - Objects"
		$HUDLine4.text = ""
		$HUDLine5.text = ""
	elif Global.is_placement_mode and not Global.is_removal_mode and not Global.is_house_placement_mode and not Global.in_house:
		$HUDLine3.text = "'E' - Exit"
		$HUDLine4.text = "'R' - Remove"
		$HUDLine5.text = "'H' - Houses"
	elif Global.is_placement_mode and not Global.is_removal_mode and Global.in_house:
		$HUDLine3.text = "'E' - Exit"
		$HUDLine4.text = "'R' - Remove"
		$HUDLine5.text = ""
	elif Global.is_placement_mode and Global.is_removal_mode and not Global.in_house:
		$HUDLine3.text = "'E' - Exit"
		$HUDLine4.text = "'R' - Objects"
		$HUDLine5.text = "'H' - Houses"
	elif Global.is_placement_mode and Global.is_removal_mode and Global.in_house:
		$HUDLine3.text = "'E' - Exit"
		$HUDLine4.text = "'R' - Objects"
		$HUDLine5.text = ""
	elif Global.is_house_placement_mode:
		$HUDLine3.text = "'E' - Exit"
		$HUDLine4.text = "'R' - Remove"
		$HUDLine5.text = "'H' - Objects"
	else:
		$HUDLine3.text = ""
		$HUDLine4.text = ""
		$HUDLine5.text = ""
		
func _unhandled_input(event):
	if event.is_action_pressed("toggle_controls"):
		visible = !visible
