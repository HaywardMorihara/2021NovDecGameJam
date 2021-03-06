extends Button

var village_id := ""
var village_name := ""

func _ready():
	text = village_name.left(30)
	if len(village_name) > 30:
		text = text + "..."

func _on_Button_pressed():
	VillageMap.reset()
	VillageMap.village_id = village_id
	VillageMap.village_name = village_name
	print("Downloading & parsing village %s" % village_id)
	yield(VillageData.download_village_data(village_id), "completed")
	if not VillageData.latest_village_data.get(name):
		VillageData.latest_village_data.name = village_name
	VillageMap.parse_village_data(VillageData.latest_village_data)
	get_tree().change_scene("res://game/Game.tscn")
