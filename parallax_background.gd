extends ParallaxBackground


@export var scroll_speed: float = -100  # Negative for left, positive for right

func _process(delta):
	scroll_offset.x += scroll_speed * delta
