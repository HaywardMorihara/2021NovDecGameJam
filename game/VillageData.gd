extends Node

# Data
var villages := [{"id": "VillageABC", "name": "Testing 11/20/2021"}] # Dicts w ids & names
var village_data := {}

# Dicts
var village_id := "VillageABC"
var village_name := "Testing 11/20/2021"
var village_map := {}
var house_maps := {}

func load_village_data():
	print("Loading village data...")
	
	var file = File.new()
	if file.open("res://villages/test_village_2.json", file.READ) != OK:
		print("ERROR loading file")
		return
	var text = file.get_as_text()
	file.close()
	
	var data_parse = JSON.parse(text)
	if data_parse.error != OK:
		print("ERROR parsing JSON %s" % text)
		return
	village_data = data_parse.result
	print("Village Data...")
	print(village_data)
	
func parse_village_data():
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
	village_map['objects'] = {}
	village_map['houses'] = {}
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
				
	print("Village Map...")
	print(village_map)
	print("House Maps...")
	print(house_maps)
	
	
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
	village_data = {}
	village_data['village'] = {}
	village_data['village']['objects'] = {}
	village_data['village']['houses'] = {}
	village_data['houses'] = {}
	for object_id in village_map.get('objects').keys():
		var object_data = village_map.get('objects').get(object_id)
		if not village_data['village']['objects'].has(object_data.get('type')):
			village_data['village']['objects'][object_data.get('type')] = []
		village_data['village']['objects'][object_data.get('type')].append({
			"x": object_data.get('x'),
			"y": object_data.get('y')
		})
	for house_id in village_map.get('houses').keys():
		var house_data = village_map.get('houses').get(house_id)
		if not village_data['village']['houses'].has(house_data.get('type')):
			village_data['village']['houses'][house_data.get('type')] = []
		village_data['village']['houses'][house_data.get('type')].append({
			"id": house_id,
			"x": house_data.get('x'),
			"y": house_data.get('y')
		})
	for house_id in house_maps.keys():
		village_data['houses'][house_id] = {"objects":{}}
		for object_id in house_maps.get(house_id).get('objects').keys():
			var object_data = house_maps.get(house_id).get('objects').get(object_id)
			if not village_data['houses'][house_id]['objects'].has(object_data.get('type')):
				village_data['houses'][house_id]['objects'][object_data.get('type')] = []
			village_data['houses'][house_id]['objects'][object_data.get('type')].append({
				"x": object_data.get('x'),
				"y": object_data.get('y')
			})
	print("Serialized data: %s" % village_data)
	
func save_village_data_local():
	serialize_village_data()
	var file = File.new()
	file.open("res://villages/test_village_2.json", File.WRITE)
	file.store_line(to_json(village_data))
	file.close()
	
	
	

	# https://silentwolf.com/playerdata
	# NOTE: HAD TO ADD THE HTTPREQUEST BEING CREATED IN Players.Data TO THE TREE (with add_child())
	
	# POST Experimentation
	# Made incorrect assumptions about how it works
#	SilentWolf.Players.post_player_data("public", {"villageNames":["testing20211114"]}, {"hello": "world"})
	# It seems like this doesn't actually work - looked at the code and doesn't seem to actually support 'character_data'
#	SilentWolf.Players.post_player_data("public", {"hello": "world"}, "testing20211114")
	
	# POST "FINAL"
	# Note: If doing this, would be worried about overwriting the whole village list...would probably want some logic to ensure this doesn't happen
#	SilentWolf.Players.post_player_data("public", {"villageNames": ["testing20211114"]})
#	SilentWolf.Players.post_player_data("testing20211114", {"objects": [{"id": "001", "x": 0.0, "y": 0.0}]})	
func upload_data():
	print("Uploading to SilentWolf...")
	SilentWolf.Players.post_player_data("villages", {"villages": villages})
	SilentWolf.Players.post_player_data(village_id, to_json(village_data))
	print("Upload complete!")

func download_and_parse_data():
	print("Downloading from SilentWolf...")
	# Villages
	yield(SilentWolf.Players.get_player_data("villages"), "sw_player_data_received")
	var villages_data = SilentWolf.Players.player_data
	villages = villages_data.get("villages")
	print("Villages Downloaded: %s" % villages)

	village_id = villages[0].get('id')
	village_name = villages[0].get('name')
	print("Fetching village data for %s" % village_id)
	yield(SilentWolf.Players.get_player_data(village_id), "sw_player_data_received")
	village_data = parse_json(SilentWolf.Players.player_data)
	print("Village %s data: %s" % [village_name, village_data])

	parse_village_data()
