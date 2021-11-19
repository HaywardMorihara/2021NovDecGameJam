extends Area2D

signal object_placed(scene_name, global_pos)
signal object_removed(type, id)

var is_placed := false

var type_id := ""
var id := ""

func _ready():
	$CollisionShape2D.visible = true

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Global.is_placement_mode and not Global.is_removal_mode and event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed and not is_placed:
		print("Should place %s" % self)
		emit_signal("object_placed", type_id, global_position)
	elif Global.is_removal_mode and event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed and is_placed:
		print("Should remove %s" % self)
		emit_signal("object_removed", type_id, id)
		get_parent().queue_free()
