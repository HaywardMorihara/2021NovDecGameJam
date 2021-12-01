extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not Global.is_placement_mode:
		$HUDLine3.text = "'E' - Objects"
		$HUDLine4.text = "'W,A,S,D - Move"
		$HUDLine5.text = ""
		$HUDLine6.text = ""
	elif Global.is_placement_mode and not Global.is_removal_mode and not Global.is_house_placement_mode and not Global.in_house:
		$HUDLine3.text = "'E' - Exit"
		$HUDLine4.text = "'R' - Remove"
		$HUDLine5.text = "'H' - Houses"
		$HUDLine6.text = "'A,D' - Next/Prev"
	elif Global.is_placement_mode and not Global.is_removal_mode and Global.in_house:
		$HUDLine3.text = "'E' - Exit"
		$HUDLine4.text = "'R' - Remove"
		$HUDLine5.text = "'A,D' - Next/Prev"
		$HUDLine6.text = ""
	elif Global.is_placement_mode and Global.is_removal_mode and not Global.in_house:
		$HUDLine3.text = "'E' - Exit"
		$HUDLine4.text = "'R' - Objects"
		$HUDLine5.text = "'H' - Houses"
		$HUDLine6.text = ""
	elif Global.is_placement_mode and Global.is_removal_mode and Global.in_house:
		$HUDLine3.text = "'E' - Exit"
		$HUDLine4.text = "'R' - Objects"
		$HUDLine5.text = ""
		$HUDLine6.text = ""
	elif Global.is_house_placement_mode:
		$HUDLine3.text = "'E' - Exit"
		$HUDLine4.text = "'R' - Remove"
		$HUDLine5.text = "'H' - Objects"
		$HUDLine6.text = "'A,D' - Next/Prev"
	else:
		$HUDLine3.text = ""
		$HUDLine4.text = ""
		$HUDLine5.text = ""
		$HUDLine6.text = ""
		
func _unhandled_input(event):
	if event.is_action_pressed("toggle_controls"):
		visible = !visible
