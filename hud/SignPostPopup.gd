extends Popup

var is_in_edit_mode := false
var id := ""

#{
#	"objects": {
#		"32141": {
#			"type": "001"
#			"x": 0.0,
#			"y": 0.0
#		} 
#	},
#	"houses": {
#		"634712846": {
#			"type": "001",
#			"x": 10.0,
#			"y": 10.0
#		}
#	}
#}

func _on_SignPostPopup_about_to_show():
	if not Global.in_house and VillageMap.village_map.objects[id].get('text'):
		$RichTextLabel.text = VillageMap.village_map.objects[id].text
	elif Global.in_house and VillageMap.house_maps[Global.in_house].objects[id].get('text'):
		$RichTextLabel.text = VillageMap.house_maps[Global.in_house].objects[id].text
	$TextEdit.hide()
	$RichTextLabel.visible = true
	is_in_edit_mode = false

func _on_SignPostPopup_popup_hide():
	pass # Replace with function body.


func _on_EditSignButton_pressed():
	if not is_in_edit_mode:
		Global.is_player_movement_enabled = false
		$TextEdit.text = $RichTextLabel.text
		$RichTextLabel.hide()
		$TextEdit.visible = true
		$EditSignButton.text = "Save"
		is_in_edit_mode = true
	elif is_in_edit_mode:
		Global.is_player_movement_enabled = true
		$RichTextLabel.text = $TextEdit.text
		$RichTextLabel.visible = true
		$TextEdit.hide()
		$EditSignButton.text = "Edit"
		is_in_edit_mode = false
		if not Global.in_house:
			VillageMap.village_map.objects[id].text = $RichTextLabel.text 
		elif Global.in_house:
			VillageMap.house_maps[Global.in_house].objects[id].text = $RichTextLabel.text
		print("Saved, house maps now: %s" % VillageMap.house_maps[Global.in_house])
