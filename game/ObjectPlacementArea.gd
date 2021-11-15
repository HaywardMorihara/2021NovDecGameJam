extends YSort

const OBJECT_PLACEMENT_SCENE := preload("res://game/ObjectPlacement.tscn")

var object_placement = null
# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _unhandled_input(event):
	if event.is_action_pressed("toggle_placement_mode"):
		if not Global.is_placement_mode:
			_enter_placement_mode()
		elif Global.is_placement_mode:
			_exit_placement_mode()
	
	if Global.is_placement_mode:
		if event.is_action_pressed("ui_right"):
			object_placement.cycle_right()
		
func _enter_placement_mode():
	print("Entering placement mode!")
	Global.is_placement_mode = true
	object_placement = OBJECT_PLACEMENT_SCENE.instance()
	object_placement.connect("object_placed", self, "_place_object")
	add_child(object_placement)


func _exit_placement_mode():
	print("Exiting placement mode...")
	Global.is_placement_mode = false
	object_placement.queue_free()

func _place_object(scene_name, global_pos):
	print("Placing scene %s" % scene_name)
	var PLACEABLE_OBJECT_SCENE := load(scene_name)
	var object = PLACEABLE_OBJECT_SCENE.instance()
	object.set_global_position(global_pos)
	add_child(object)
