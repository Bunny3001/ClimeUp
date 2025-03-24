extends AnimatableBody2D

@export var speed: float = 100.0       # Speed in pixels per second.
@export var left_limit: float = 0.0      # Left boundary.
@export var right_limit: float = 400.0   # Right boundary.

var direction: int = 1                   # 1 moves right, -1 moves left.

func _physics_process(delta: float) -> void:
	# Update the platform's position manually.
	position.x += speed * direction * delta

	# Reverse direction and clamp position when reaching boundaries.
	if position.x >= right_limit:
		direction = -1
		position.x = right_limit
	elif position.x <= left_limit:
		direction = 1
		position.x = left_limit
