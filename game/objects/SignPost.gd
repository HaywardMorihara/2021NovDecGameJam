extends StaticBody2D


func _on_Area2D_body_entered(body):
	if $ObjectPlacement.is_placed and body.name == "Player":
		print("TODO Pop up sign post")
		$SignPostPopup.popup()


func _on_Area2D_body_exited(body):
	if $ObjectPlacement.is_placed and body.name == "Player":
		print("TODO Exit sign post")
		$SignPostPopup.hide()
