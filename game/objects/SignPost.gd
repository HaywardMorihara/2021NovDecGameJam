extends StaticBody2D

func _ready():
	$SignPostPopup.id = $ObjectPlacement.id


func _on_Area2D_body_entered(body):
	if $ObjectPlacement.is_placed and body.name == "Player":
		# Needed, because not using popup(), because that seems to reset the position
		$SignPostPopup.enable()
		$SignPostPopup.rect_position = self.position + Vector2(-47.0, -50.0)
		$SignPostPopup.show()


func _on_Area2D_body_exited(body):
	if $ObjectPlacement.is_placed and body.name == "Player":
		$SignPostPopup.hide()
