extends Node

# Data
var village_names := []
var village_data := {}

# Game State
var is_placement_mode := false
var is_removal_mode := false


# DEBUG
var village_test_data := {
	"town": {
		"objects": [
			{
				"object_type": "001",
				"x": 0.0,
				"y": 0.0
			}
		]
	},
	"houses": [
		{
			"house_id": "random? increment? player assinged?",
			"house_type": "001",
			"x": 20.0,
			"y": 0.0
		}
	]
}


# Called when the node enters the scene tree for the first time.
func _ready():
	# DEBUG
	if village_test_data:
		village_data = village_test_data
	
	var api_key_file = File.new()
	api_key_file.open("res://api_key.env", File.READ)
	var api_key = api_key_file.get_line()
	api_key_file.close()
	
	SilentWolf.configure({
		"api_key": api_key,
		"game_id": "2021NovDevGameJam",
		"game_version": "0.0.1",
		"log_level": 1
	})
	
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

	# GET
#	yield(SilentWolf.Players.get_player_data("public"), "sw_player_data_received")
#	var public_data = SilentWolf.Players.player_data
#	village_names = public_data.get("villageNames")
#	print("Village Names: " + str(village_names))
#
#	yield(SilentWolf.Players.get_player_data(village_names[0]), "sw_player_data_received")
#	village_data = SilentWolf.Players.player_data
#	village_data = SilentWolf.Players.player_data
#	print("Village data: " + str(village_data))
#	village_objects = village_data.get("objects")
#	print("Village objects: " + str(village_objects))

	# FROM DEBUGGING
	# NEEDED TO ADD TO TREE
#	var node := HTTPRequest.new()
##	add_child(node)
#	print("here")
#	node.connect("request_completed", self, "_on_request_completed")
#	node.request("http://www.mocky.io/v2/5185415ba171ea3a00704eed")

# From debugging how to make request
#func _on_request_completed(result, response_code, headers, body):
#	var json = JSON.parse(body.get_string_from_utf8())
#	print(json.result)
