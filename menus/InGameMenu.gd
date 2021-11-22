extends Popup

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		popup()

func _on_InGameMenu_popup_hide():
	print("Unpausing the game")
	Global.is_paused = false
	get_tree().paused = false


func _on_InGameMenu_about_to_show():
	print("Pausing the game")
	Global.is_paused = true
	get_tree().paused = true
