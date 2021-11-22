extends Button


func _on_SaveButton_pressed():
	VillageMap.serialize_village_data()
	VillageData.upload_village_data(VillageMap.village_id, VillageMap.latest_serialized_village_data)
