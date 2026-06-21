extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400


@onready var sprite_2d = $Sprite2D
var jump_count = 0

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and jump_count < 2:
		jump_count += 1
		velocity.y = JUMP_VELOCITY

	# Movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()  # <-- floor state updates HERE

	# Reset jump AFTER move_and_slide so is_on_floor() is accurate
	if is_on_floor():
		jump_count = 0

	# Flip sprite
	if velocity.x != 0:
		sprite_2d.flip_h = velocity.x < 0

	# Animation priority: Jump > Running > Idle
	var new_anim: String
	if not is_on_floor():
		new_anim = "Jump"
	elif abs(velocity.x) > 1:
		new_anim = "Running"
	else:
		new_anim = "default"

	# Only change animation when needed — prevents restarting every frame
	if sprite_2d.animation != new_anim:
		sprite_2d.play(new_anim)
