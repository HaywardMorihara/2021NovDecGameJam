extends YSort

#const OBJECT_PLACEMENT_SCENE := preload("res://game/ObjectPlacement.tscn")
const SCENES_FOR_PLACEMENT := [
	preload("res://game/objects/LampPost.tscn"),
	preload("res://game/objects/Tree1.tscn")
]

var scene_current_index = 0
var object_for_placement = null

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.is_placement_mode and object_for_placement != null:
		object_for_placement.global_position = get_global_mouse_position()

func _unhandled_input(event):
	if event.is_action_pressed("toggle_placement_mode"):
		if not Global.is_placement_mode:
			_enter_placement_mode()
		elif Global.is_placement_mode:
			_exit_placement_mode()
	
	if Global.is_placement_mode:
		if event.is_action_pressed("ui_right"):
			_cycle_right()
		
func _enter_placement_mode():
	print("Entering placement mode!")
	Global.is_placement_mode = true
	_init_object_for_placement()

func _exit_placement_mode():
	print("Exiting placement mode...")
	Global.is_placement_mode = false
	object_for_placement.queue_free()

func _place_object(scene_name, global_pos):
	print("Placing scene %s" % scene_name)
	var PLACEABLE_OBJECT_SCENE := load(scene_name)
	var object = PLACEABLE_OBJECT_SCENE.instance()
	object.set_global_position(global_pos)
	add_child(object)

func _init_object_for_placement():
	if object_for_placement and is_instance_valid(object_for_placement):
		object_for_placement.queue_free()
	object_for_placement = SCENES_FOR_PLACEMENT[scene_current_index].instance()
	object_for_placement.get_node("ObjectPlacement").connect("object_placed", self, "_place_object")
	add_child(object_for_placement)

func _cycle_right():
	print("Changing object to be placed...")
	if scene_current_index + 1 == len(SCENES_FOR_PLACEMENT):
		scene_current_index = 0
	else:
		scene_current_index += 1
	_init_object_for_placement()
