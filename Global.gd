extends Node

# Game State
var is_placement_mode := false
var is_removal_mode := false
var is_house_placement_mode := false
var in_house: String
var coming_from: String
var is_paused := false
var just_started := true
var is_player_movement_enabled := true

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
