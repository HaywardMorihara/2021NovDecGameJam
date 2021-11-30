extends Node

# Game State
var is_placement_mode := false
var is_removal_mode := false
var is_house_placement_mode := false
var in_house: String
var coming_from: String
var is_paused := false
var just_started := true

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
	
	# DEBUG Fix Data
#	var villages := [{"id": "923e194f-d19b-4d35-83fd-598d61", "name": "Test 1"}]
#	VillageData.upload_villages(villages)
