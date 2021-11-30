extends Popup


func set_text(text):
	$RichTextLabel.text = text

func _on_PopupNotice_popup_hide():
	Global.just_started = false

func _on_Button_pressed():
	hide()
