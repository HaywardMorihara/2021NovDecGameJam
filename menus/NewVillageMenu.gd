extends Control

const uuid_util = preload('res://addons/uuid.gd')


func _on_Button_pressed():
	VillageMap.reset()
	VillageMap.village_id = uuid_util.v4().left(30)
	VillageMap.village_name = $TextEdit.text
	yield(VillageData.download_villages(), "completed")
	var latest_villages = VillageData.latest_villages
	latest_villages.append({"id": VillageMap.village_id, "name": VillageMap.village_name})
	VillageData.upload_villages(latest_villages)
	get_tree().change_scene("res://game/Game.tscn")
