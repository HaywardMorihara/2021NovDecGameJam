extends Popup


func _on_InGameMenu_popup_hide():
	get_tree().paused = false
