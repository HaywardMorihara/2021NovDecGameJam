extends Area2D

signal object_placed(scene_name, global_pos)

func _ready():
	var placement_shape := $PlaceableObject/PlacementShape
	placement_shape.disabled = false
	$PlaceableObject.remove_child(placement_shape)
	add_child(placement_shape)
	placement_shape.set_owner(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = get_global_mouse_position()


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("object_placed", "res://game/objects/PlaceableObject.tscn", global_position)

func cycle_right():
	print("Changing object to be placed...")
