extends Area2D

var is_placed := false

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_placed:
		position = get_global_mouse_position()


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if not is_placed and event.button_index == BUTTON_LEFT and event.pressed:
			is_placed = true
		elif is_placed and event.button_index == BUTTON_RIGHT and event.pressed:
			is_placed = false
