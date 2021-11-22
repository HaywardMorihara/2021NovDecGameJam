extends Node

var latest_villages := []
var latest_village_data := {}

# DEBUGGING
func load_village_data(file_path):
	print("Loading village data...")
	
	var file = File.new()
	if file.open(file_path, file.READ) != OK:
		print("ERROR loading file")
		return
	var text = file.get_as_text()
	file.close()
	
	var data_parse = JSON.parse(text)
	if data_parse.error != OK:
		print("ERROR parsing JSON %s" % text)
		return
	return data_parse.result
	

	
# DEBUGGING
func save_village_data_local(file_path):
	var village_data = VillageMap.serialize_village_data()
	var file = File.new()
	file.open(file_path, File.WRITE)
	file.store_line(to_json(village_data))
	file.close()
	
	
# https://silentwolf.com/playerdata
# NOTE: HAD TO ADD THE HTTPREQUEST BEING CREATED IN Players.Data TO THE TREE (with add_child())
	
func upload_villages(villages):
	print("Uploading village list to SilentWolf")
	SilentWolf.Players.post_player_data("villages", {"villages": villages})
	
func upload_village_data(this_village_id, this_village_data):
	print("Uploading data about village %s to SilentWolf..." % this_village_id )
	print("Uploading data: %s" % to_json(this_village_data))
	SilentWolf.Players.post_player_data(this_village_id, to_json(this_village_data))

func download_villages():
	print("Downloading village list from SilentWolf")
	yield(SilentWolf.Players.get_player_data("villages"), "sw_player_data_received")
	var villages_data = SilentWolf.Players.player_data
	var villages = villages_data.get("villages")
	latest_villages = villages

func download_village_data(village_id):
	print("Fetching village data for %s" % village_id)
	yield(SilentWolf.Players.get_player_data(village_id), "sw_player_data_received")
	latest_village_data = parse_json(SilentWolf.Players.player_data)
