extends Control

var BUTTON_SCENE = preload("res://menus/buttons/LoadVillageButton.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(VillageData.download_villages(), "completed")
	print(VillageData.latest_villages)
	for village in VillageData.latest_villages:
		print("Adding button for village %s" % village)
		var village_button = BUTTON_SCENE.instance()
		village_button.village_id = village.id
		village_button.village_name = village.name
		village_button.connect("pressed", village_button, "_on_Button_pressed")
		$ScrollContainer/VBoxContainer.add_child(village_button)
