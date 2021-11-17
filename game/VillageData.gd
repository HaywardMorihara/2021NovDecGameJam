extends Node

# Data
var village_names := []
var village_data := {}

func load_village_data():
	print("Loading village data...")
	
	var file = File.new()
	if file.open("res://villages/test_village_1.json", file.READ) != OK:
		print("ERROR loading file")
		return
	var text = file.get_as_text()
	file.close()
	
	var data_parse = JSON.parse(text)
	if data_parse.error != OK:
		print("ERROR parsing JSON %s" % text)
		return
	village_data = data_parse.result
	print(village_data)
	
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
