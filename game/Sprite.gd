extends Area2D

var is_placed := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_placed:
		position = get_global_mouse_position()

# "unhandled" so that it doesn't happen if someone clicking in a text box or something
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			is_placed = true
