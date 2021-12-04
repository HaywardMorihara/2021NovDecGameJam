extends StaticBody2D

func _ready():
	$SignPostPopup.id = $ObjectPlacement.id


func _on_Area2D_body_entered(body):
	if $ObjectPlacement.is_placed and body.name == "Player":
		$SignPostPopup.popup()


func _on_Area2D_body_exited(body):
	if $ObjectPlacement.is_placed and body.name == "Player":
		$SignPostPopup.hide()
