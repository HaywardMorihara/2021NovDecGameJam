extends Node

# Parsed Maps
var village_id := ""
var village_name := ""
var village_map := {
	"objects": {},
	"houses": {}
}
var house_maps := {}

# Serialized Data
var latest_serialized_village_data := {}

func reset():
	village_id = ""
	village_name = ""
	village_map = {
		"objects": {},
		"houses": {}
	}
	house_maps = {}
	latest_serialized_village_data = {}

func parse_village_data(village_data):
	# Parsed Village Data
#{
#	"objects": {
#		"32141": {
#			"type": "001"
#			"x": 0.0,
#			"y": 0.0
#		} 
#	},
#	"houses": {
#		"634712846": {
#			"type": "001",
#			"x": 10.0,
#			"y": 10.0
#		}
#	}
#}
	village_id = village_data.get('id')
	village_name = village_data.get('name')
	# Parse Village Data Objects
	var village_objects = village_data.get('village').get('objects')
	for object_type in village_objects.keys():
		for object in village_objects.get(object_type):
			var id = str(object.hash())
			village_map['objects'][id] = object
			village_map['objects'][id]['type'] = object_type
	# Parse Village Houses
	var village_houses = village_data.get('village').get('houses')
	for house_type in village_houses.keys():
		for house in village_houses.get(house_type):
			var id = str(house.get('id'))
			village_map['houses'][id] = house
			village_map['houses'][id]['type'] = house_type
			
	# Parse House Data
#{
#	"634712846": {
#		"objects": {
#			"32141": {
#				"type": "001"
#				"x": 0.0,
#				"y": 0.0
#			} 
#		}
#	}	
#}
	var house_data = village_data.get('houses')
	for house_id in house_data.keys():
		house_maps[house_id] = {'objects':{}}
		var house_objects = house_data.get(house_id).get('objects')
		for object_type in house_objects.keys():
			for object in house_objects.get(object_type):
				var id = str(object.hash())
				house_maps[house_id]['objects'][id] = object
				house_maps[house_id]['objects'][id]['type'] = object_type
				
#	print("Village Map...")
#	print(village_map)
#	print("House Maps...")
#	print(house_maps)
	
	
#{
#	"objects": {
#		"32141": {
#			"type": "001"
#			"x": 0.0,
#			"y": 0.0
#		} 
#	},
#	"houses": {
#		"634712846": {
#			"type": "001",
#			"x": 10.0,
#			"y": 10.0
#		}
#	}
#}
#{
#	"634712846": {
#		"objects": {
#			"32141": {
#				"type": "001"
#				"x": 0.0,
#				"y": 0.0
#			} 
#		}
#	}	
#}
func serialize_village_data():
	latest_serialized_village_data = {
		"id": village_id,
		"name": village_name,
		"village": {
			"objects": {},
			"houses": {}
		},
		"houses": {
			
		}
	}
	for object_id in village_map.get('objects').keys():
		var object_data = village_map.get('objects').get(object_id)
		if not latest_serialized_village_data['village']['objects'].has(object_data.get('type')):
			latest_serialized_village_data['village']['objects'][object_data.get('type')] = []
		latest_serialized_village_data['village']['objects'][object_data.get('type')].append({
			"x": object_data.get('x'),
			"y": object_data.get('y')
		})
	for house_id in village_map.get('houses').keys():
		var house_data = village_map.get('houses').get(house_id)
		if not latest_serialized_village_data['village']['houses'].has(house_data.get('type')):
			latest_serialized_village_data['village']['houses'][house_data.get('type')] = []
		latest_serialized_village_data['village']['houses'][house_data.get('type')].append({
			"id": house_id,
			"x": house_data.get('x'),
			"y": house_data.get('y')
		})
	for house_id in house_maps.keys():
		latest_serialized_village_data['houses'][house_id] = {"objects":{}}
		for object_id in house_maps.get(house_id).get('objects').keys():
			var object_data = house_maps.get(house_id).get('objects').get(object_id)
			if not latest_serialized_village_data['houses'][house_id]['objects'].has(object_data.get('type')):
				latest_serialized_village_data['houses'][house_id]['objects'][object_data.get('type')] = []
			latest_serialized_village_data['houses'][house_id]['objects'][object_data.get('type')].append({
				"x": object_data.get('x'),
				"y": object_data.get('y')
			})
	return
