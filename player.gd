extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -800.0

var MAX_JUMPS = 2
var jumps_left = 2

var MAX_DASHES = 1
var dashes_left = 1


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Regain jump + dash on ground,,,
	if is_on_floor():
		jumps_left = MAX_JUMPS
		dashes_left = MAX_DASHES
	
	# Handle jump.
	
	handle_inputs_etc()
	move_and_slide()

func handle_inputs_etc() -> void:
	if Input.is_action_just_pressed("jump") and jumps_left > 0:
		jump()
	if Input.is_action_just_pressed("dash") and dashes_left > 0:
		dash();
	move_around()



## THINGS THAT THE PLAYER LIKE DOES. LIKE IDK. JUMPING.
func jump() -> void:
	velocity.y = JUMP_VELOCITY
	jumps_left -= 1

func dash() -> void:
	# PLACEHOLDER. FIX DASHES IDIOT
	velocity.y = JUMP_VELOCITY
	dashes_left -= 1

func move_around() -> void:
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
