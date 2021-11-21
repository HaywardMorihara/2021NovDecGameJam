extends Node2D


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		print("here?")
		$InGameMenu.popup()
		get_tree().paused = true
		
	# TODO DEBUGGING - should remove
	if event.is_action_pressed("save_village_data"):
		VillageData.save_village_data_local()
		VillageData.upload_data()
