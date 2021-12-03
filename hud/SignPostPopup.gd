extends Popup

var is_in_edit_mode := false
var sign_text := ""

func _on_SignPostPopup_about_to_show():
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
