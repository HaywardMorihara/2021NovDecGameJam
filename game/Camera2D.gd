extends Camera2D

# The camera's target zoom level
var _zoom_level := 1.0

func _unhandled_input(event):
	# https://www.gdquest.com/tutorial/godot/2d/camera-zoom/
	# Controls how much we increase or decrease the `_zoom_level` on every turn of the scroll wheel.
	var zoom_factor := 0.1
	if event.is_action_pressed("zoom_in"):
		# Inside a given class, we need to either write `self._zoom_level = ...` or explicitly
		# call the setter function to use it.
		print("Zooming in...")
		_set_zoom_level(_zoom_level - zoom_factor)
	if event.is_action_pressed("zoom_out"):
		print("Zooming out...")
		_set_zoom_level(_zoom_level + zoom_factor)

func _set_zoom_level(value: float) -> void:
	var tween = $Tween
	# Lower cap for the `_zoom_level`.
	var min_zoom := 0.5
	# Upper cap for the `_zoom_level`.
	var max_zoom := 3.0
	# Duration of the zoom's tween animation.
	var zoom_duration := 0.2
	# We limit the value between `min_zoom` and `max_zoom`
	_zoom_level = clamp(value, min_zoom, max_zoom)
	# Then, we ask the tween node to animate the camera's `zoom` property from its current value
	# to the target zoom level.
	tween.interpolate_property(
		self,
		"zoom",
		zoom,
		Vector2(_zoom_level, _zoom_level),
		zoom_duration,
		tween.TRANS_SINE,
		# Easing out means we start fast and slow down as we reach the target value.
		tween.EASE_OUT
	)
	tween.start()
