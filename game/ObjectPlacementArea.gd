extends YSort

var object_for_placement = null
var object_scene_current_index = 0
var house_scene_current_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_render_village_data()
	
func _render_village_data():
	if not VillageMap.village_id or not VillageMap.village_map:
		return
	print("Rendering village for village %s, %s" % [VillageMap.village_id, VillageMap.village_name])
	print("In house %s" % Global.in_house)
	if Global.in_house.empty():
		for village_object_id in VillageMap.village_map.get('objects'):
			var object = VillageMap.village_map.get('objects').get(village_object_id)
#			print("Rendering %s" % object)
			_place_object(object.get("type"), Vector2(object.get("x"), object.get("y")), village_object_id)
		for house_id in VillageMap.village_map.get('houses'):
			var house = VillageMap.village_map.get('houses').get(house_id)
#			print("Rendering %s" % house)
			_place_object(house.get("type"), Vector2(house.get("x"), house.get("y")), house_id)
	else:
		print("Rendering house data %s" % Global.in_house)
		if not VillageMap.house_maps.get(Global.in_house):
			VillageMap.house_maps[Global.in_house] = {"objects": {}}
		for house_object_id in VillageMap.house_maps.get(Global.in_house).get('objects'):
			var object = VillageMap.house_maps.get(Global.in_house).get('objects').get(house_object_id)
			_place_object(object.get("type"), Vector2(object.get("x"), object.get("y")), house_object_id)


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
		if event.is_action_pressed("ui_left"):
			_cycle_left()
	
		
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

func _place_object(type_id, global_pos, id=""):
	var scene
	if type_id[0] == 'h':
		scene = PlaceableObjects.HOUSES_FOR_PLACEMENT.get(type_id)
	else:
		scene = PlaceableObjects.OBJECTS_FOR_PLACEMENT.get(type_id)
	print("Placing scene %s" % scene)
	var object = scene.instance()
	object.get_node("ObjectPlacement").is_placed = true
	object.get_node("ObjectPlacement").connect("object_removed", self, "_remove_object")
	object.set_global_position(global_pos)
	if not id:
		var pos_dict := {}
		pos_dict['x'] = global_pos.x
		pos_dict['y'] = global_pos.y
		id = str(pos_dict.hash())
		print("Created ID %s" % id)
	object.get_node("ObjectPlacement").id = id
	object.get_node("ObjectPlacement").type_id = type_id
	if type_id[0] == 'h':
		object.id = id
	add_child(object)
	if not Global.in_house.empty() and not VillageMap.house_maps[Global.in_house]['objects'].get(id):
		VillageMap.house_maps[Global.in_house]['objects'][id] = {
			"type": type_id,
			"x": global_pos.x,
			"y": global_pos.y,
		}
#		print("Current map: %s" % VillageMap.house_maps[Global.in_house])
	else:
#		print("Adding %s of type %s to the VillageMap" % [id, type_id])
		if type_id[0] == 'h' and not VillageMap.village_map['houses'].get(id):
			VillageMap.village_map['houses'][id] = {
				"type": type_id,
				"x": global_pos.x,
				"y": global_pos.y
			}
		elif not VillageMap.village_map['objects'].get(id):
			VillageMap.village_map['objects'][id] = {
				"type": type_id,
				"x": global_pos.x,
				"y": global_pos.y
			}
#		print("Current map: %s" % VillageMap.village_map)

func _remove_object(type, id):
	print("Removing %s of type %s" % [id, type])
	if Global.in_house:
		print("Remove from house %s" % Global.in_house)
		VillageMap.house_maps[Global.in_house]['objects'].erase(id)
#		print("Current map: %s" % VillageMap.house_map[Global.in_house])
	else:
		if type[0] == 'h':
			VillageMap.village_map['houses'].erase(id)
			VillageMap.house_maps.erase(id)
		else:
			print("Removing from the objects of the village map")
			var was_erased = VillageMap.village_map['objects'].erase(id)
			print("Was erased: %s" % was_erased)
		print("Current village map: %s" % VillageMap.village_map)
		print("Current hosue maps: %s" % VillageMap.house_maps)

func _init_object_for_placement():
	if object_for_placement and is_instance_valid(object_for_placement):
		object_for_placement.queue_free()
	if not Global.is_house_placement_mode:
		var object_scene_key = PlaceableObjects.OBJECTS_FOR_PLACEMENT_KEYS[object_scene_current_index]
		object_for_placement = PlaceableObjects.OBJECTS_FOR_PLACEMENT[object_scene_key].instance()		
		object_for_placement.get_node("ObjectPlacement").type_id = object_scene_key
	elif Global.is_house_placement_mode:
		var house_scene_key = PlaceableObjects.HOUSES_FOR_PLACEMENT_KEYS[house_scene_current_index]
		object_for_placement = PlaceableObjects.HOUSES_FOR_PLACEMENT[house_scene_key].instance()
		object_for_placement.get_node("ObjectPlacement").type_id = house_scene_key
	object_for_placement.get_node("ObjectPlacement").connect("object_placed", self, "_place_object")
	add_child(object_for_placement)

func _cycle_right():
	if not Global.is_house_placement_mode:
		if object_scene_current_index + 1 == len(PlaceableObjects.OBJECTS_FOR_PLACEMENT):
			object_scene_current_index = 0
		else:
			object_scene_current_index += 1
	if Global.is_house_placement_mode:
		if house_scene_current_index + 1 == len(PlaceableObjects.HOUSES_FOR_PLACEMENT):
			house_scene_current_index = 0
		else:
			house_scene_current_index += 1
	_init_object_for_placement()

func _cycle_left():
	if not Global.is_house_placement_mode:
		if object_scene_current_index - 1 < 0:
			object_scene_current_index = len(PlaceableObjects.OBJECTS_FOR_PLACEMENT) - 1
		else:
			object_scene_current_index -= 1
	if Global.is_house_placement_mode:
		if house_scene_current_index - 1 < 0:
			house_scene_current_index = len(PlaceableObjects.HOUSES_FOR_PLACEMENT) - 1
		else:
			house_scene_current_index -= 1
	_init_object_for_placement()
