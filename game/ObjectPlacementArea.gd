extends YSort

var object_for_placement = null
var object_scene_current_index = 0
var house_scene_current_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_render_village_data()
	
func _render_village_data():
	if not Global.in_house:
		print("Rendering village data")
		var village_objects = VillageData.village_data.get("village").get("objects")
		for object_type in village_objects.keys():
			for object in village_objects[object_type]:
				# TODO Should map IDs or something
				_place_object("res://game/objects/LampPost.tscn", Vector2(object.get("x"), object.get("y")))
	else:
		print("Rendering house data %s" % Global.in_house)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.is_placement_mode and not Global.is_removal_mode and object_for_placement and is_instance_valid(object_for_placement):
		object_for_placement.global_position = get_global_mouse_position()

func _unhandled_input(event):
	if event.is_action_pressed("toggle_placement_mode"):
		if not Global.is_placement_mode:
			_enter_placement_mode()
		elif Global.is_placement_mode:
			_exit_removal_mode()
			_exit_house_placement_mode()
			_exit_placement_mode()
	
	if Global.is_placement_mode:
		if event.is_action_pressed("toggle_removal_mode"):
			if not Global.is_removal_mode:
				_exit_house_placement_mode()
				_enter_removal_mode()
			elif Global.is_removal_mode:
				_exit_removal_mode()
				_enter_placement_mode()
		if not Global.in_house and event.is_action_pressed("toggle_house_placement_mode"):
			if not Global.is_house_placement_mode:
				_exit_removal_mode()
				_enter_house_placement_mode()
			elif Global.is_house_placement_mode:
				_exit_house_placement_mode()
				_enter_placement_mode()
		if event.is_action_pressed("ui_right"):
			_cycle_right()
		
func _enter_placement_mode():
	print("Entering placement mode!")
	Global.is_placement_mode = true
	_init_object_for_placement()
	
func _enter_house_placement_mode():
	print("Entering house placement mode...")
	Global.is_house_placement_mode = true
	if object_for_placement and is_instance_valid(object_for_placement):
		object_for_placement.queue_free()
	_init_object_for_placement()

func _enter_removal_mode():
	print("Entering removal mode...")
	Global.is_removal_mode = true
	if object_for_placement and is_instance_valid(object_for_placement):
		object_for_placement.queue_free()
	
func _exit_placement_mode():
	print("Exiting placement mode...")
	Global.is_placement_mode = false
	if object_for_placement and is_instance_valid(object_for_placement):
		object_for_placement.queue_free()
	
func _exit_house_placement_mode():
	print("Exiting house placement mode...")
	Global.is_house_placement_mode = false
	if object_for_placement and is_instance_valid(object_for_placement):
		object_for_placement.queue_free()

func _exit_removal_mode():
	print("Exiting removal mode...")
	Global.is_removal_mode = false

func _place_object(scene_name, global_pos):
	print("Placing scene %s" % scene_name)
	var PLACEABLE_OBJECT_SCENE := load(scene_name)
	var object = PLACEABLE_OBJECT_SCENE.instance()
	object.get_node("ObjectPlacement").is_placed = true
	object.set_global_position(global_pos)
	add_child(object)

func _init_object_for_placement():
	if object_for_placement and is_instance_valid(object_for_placement):
		object_for_placement.queue_free()
	if not Global.is_house_placement_mode:
		object_for_placement = PlaceableObjects.OBJECTS_FOR_PLACEMENT[object_scene_current_index].instance()
	elif Global.is_house_placement_mode:
		object_for_placement = PlaceableObjects.HOUSES_FOR_PLACEMENT[house_scene_current_index].instance()
	object_for_placement.get_node("ObjectPlacement").connect("object_placed", self, "_place_object")
	add_child(object_for_placement)

func _cycle_right():
	print("Changing object to be placed...")
	if not Global.is_house_placement_mode:
		if object_scene_current_index + 1 == len(PlaceableObjects.OBJECTS_FOR_PLACEMENT):
			object_scene_current_index = 0
		else:
			object_scene_current_index += 1
	if Global.is_house_placement_mode:
		if house_scene_current_index + 1 == len(PlaceableObjects.HOUSES_FOR_PLACEMENT):
			house_scene_current_index = 0
		else:
			house_scene_current_index = 0
	_init_object_for_placement()
