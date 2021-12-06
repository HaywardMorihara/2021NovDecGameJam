extends Control

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
	
	# FIND & DELTE Village
	yield(SilentWolf.Players.get_player_data("villages"), "sw_player_data_received")
	var villages_data = SilentWolf.Players.player_data
	# TODO
	
	# GET Villages Data
#	yield(SilentWolf.Players.get_player_data("villages"), "sw_player_data_received")
#	var villages_data = SilentWolf.Players.player_data
#	print("VILLAGES DATA:")
#	print(villages_data)
	
	# GET Village Data
#	var village_id := "923e194f-d19b-4d35-83fd-598d61"
#	yield(SilentWolf.Players.get_player_data(village_id), "sw_player_data_received")
#	var village_data = SilentWolf.Players.player_data
#	print("VILLAGE %s" % village_id)
#	print(village_data)
	
	# DELETE Player Data
#	SilentWolf.Players.delete_all_player_data("923e194f-d19b-4d35-83fd-598d61")
	# If "delete" doesn't work...
#	SilentWolf.Players.post_player_data("923e194f-d19b-4d35-83fd-598d61", {})
	
	# DEBUG Fix Data
#	var villages := [{"id": "923e194f-d19b-4d35-83fd-598d61", "name": "Test 1"}]
#	VillageData.upload_villages(villages)
