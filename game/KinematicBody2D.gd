extends KinematicBody2D


var speed = 80
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass	

func _get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
func _physics_process(delta):
	_get_input()
	velocity = move_and_slide(velocity)
	# TODO Probably should have this somehwere else...but I think it needs to
	# be part of _physics_process for optmization
	if velocity.length() == 0:
		# TODO Point this in the direction that the player was going last
		$AnimatedSprite.animation = "default"
	else:		
		if abs(velocity.x) >= abs(velocity.y):
			if velocity.x < 0:
				$AnimatedSprite.animation = "left"
			else:
				$AnimatedSprite.animation = "right"
		else:
			if velocity.y < 0:
				$AnimatedSprite.animation = "up"
			else:
				$AnimatedSprite.animation = "down"
		$AnimatedSprite.playing = true
#		if not $AudioStreamPlayer2D.playing:
#			$AudioStreamPlayer2D.play()
