extends Area2D

signal object_placed(scene_name, global_pos)


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var scene_path := get_parent().filename
			emit_signal("object_placed", scene_path, global_position)
