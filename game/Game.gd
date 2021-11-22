extends Node2D


func _unhandled_input(event):
	# TODO DEBUGGING - should remove
	if event.is_action_pressed("save_village_data"):
		print("TODO Serialize & upload village data")
