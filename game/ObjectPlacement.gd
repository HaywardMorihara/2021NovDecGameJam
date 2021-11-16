extends Area2D

signal object_placed(scene_name, global_pos)

var is_placed := false

func _read():
	$CollisionShape2D.visible = true

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Global.is_placement_mode and not Global.is_removal_mode and event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed and not is_placed:
		print("Should place %s" % self)
		var scene_path := get_parent().filename
		emit_signal("object_placed", scene_path, global_position)
	elif Global.is_removal_mode and event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed and is_placed:
		print("Should remove %s" % self)
		get_parent().queue_free()
