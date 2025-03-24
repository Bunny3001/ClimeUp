extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -300.0
const COYOTE_TIME = 0.2  # seconds

@export var allow_variable_jump: bool = false
@export var allow_double_jump: bool = false

var coyote_timer = 0.0
var jump_count = 0
var jump_requested = false
var was_on_floor: bool = false

func _input(event: InputEvent) -> void:
	# Capture jump input immediately.
	if event.is_action_pressed("ui_accept"):
		jump_requested = true

func _physics_process(delta: float) -> void:
	# Cache the floor state.
	var on_floor = is_on_floor()

	# Detect landing: if we weren't on the floor last frame but now we are.
	if not was_on_floor and on_floor:
		# LandingSound removed.
		pass
	was_on_floor = on_floor

	# Update coyote timer and reset jump count when on the floor.
	if on_floor:
		coyote_timer = COYOTE_TIME
		jump_count = 0
	else:
		coyote_timer -= delta

	# Process buffered jump input.
	if jump_requested:
		if on_floor or coyote_timer > 0.0:
			velocity.y = JUMP_VELOCITY
			coyote_timer = 0.0  # Stop further jumps using coyote time.
			jump_count = 1
			if has_node("JumpSound"):
				$JumpSound.play()
		elif allow_double_jump and jump_count < 2:
			velocity.y = JUMP_VELOCITY
			jump_count += 1
			if has_node("JumpSound"):
				$JumpSound.play()
		jump_requested = false

	# Variable jump height when jump is released early.
	if allow_variable_jump and Input.is_action_just_released("ui_accept") and velocity.y < 0:
		velocity.y *= 0.5

	# Apply gravity if not on the floor.
	if not on_floor:
		velocity += get_gravity() * delta

	# Horizontal movement.
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED if direction != 0 else move_toward(velocity.x, 0, SPEED)

	# Debug print to verify direction value.
	# Uncomment the next line if you need to debug.
	# print("Direction: ", direction)

	# Flip the sprite based on movement direction.
	if has_node("Sprite"):
		if direction < 0:
			$Sprite.flip_h = true
		elif direction > 0:
			$Sprite.flip_h = false

	move_and_slide()
