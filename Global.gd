extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
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
	# Made incorrect assumptions about how it works
#	SilentWolf.Players.post_player_data("public", {"villageNames":["testing20211114"]}, {"hello": "world"})
	# It seems like this doesn't actually work - looked at the code and doesn't seem to actually support 'character_data'
#	SilentWolf.Players.post_player_data("public", {"hello": "world"}, "testing20211114")

	# Note: If doing this, would be worried about overwriting the whole village list...would probably want some logic to ensure this doesn't happen
#	SilentWolf.Players.post_player_data("public", {"villageNames": ["testing20211114"]})
	
	print("here?")
	yield(SilentWolf.Players.get_player_data("public"), "sw_player_data_received")
	print("here?")
	print("Player data: " + str(SilentWolf.Players.player_data))

	# NEED TO ADD TO TREE
#	var node := HTTPRequest.new()
##	add_child(node)
#	print("here")
#	node.connect("request_completed", self, "_on_request_completed")
#	node.request("http://www.mocky.io/v2/5185415ba171ea3a00704eed")

# From debugging how to make request
#func _on_request_completed(result, response_code, headers, body):
#	var json = JSON.parse(body.get_string_from_utf8())
#	print(json.result)
