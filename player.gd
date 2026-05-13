extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -800.0
const DASH_VELOCITY_ABS = 1000
const DASH_LEN = 0.25

var MAX_JUMPS = 2
var jumps_left = 2

var MAX_DASHES = 1
var dashes_left = 1
var is_dashing = false
var dash_dir_y = 0;
var dash_dir_x = 0;
var curr_dash_len = 0;

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Regain jump + dash on ground,,,
	if is_on_floor():
		jumps_left = MAX_JUMPS
		dashes_left = MAX_DASHES
	
	# Handle jump.
	
	if (is_dashing == false): handle_inputs_etc(); move_and_slide();
	else: handle_dash(delta);
	

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
	# PLACEHOLDER. FIX DASHES IDIOT # :( 
	var x_dir = Input.get_axis("left", "right")
	var y_dir = Input.get_axis("up", "down")
	curr_dash_len = DASH_LEN
	dashes_left -= 1
	#velocity.x = 0
	#velocity.y = 0
	is_dashing = true;
	dash_dir_x = 0
	dash_dir_y = 0
	if (x_dir == 0 && y_dir == 0):
		dash_dir_x = 1
	elif (x_dir == 0 || y_dir == 0): #straight one direction
		dash_dir_x = x_dir
		dash_dir_y = y_dir
	else:
		dash_dir_x = x_dir/2
		dash_dir_y = y_dir/2
		
	
	#if (x_dir == 0 && y_dir == 0): # no orientation
		#velocity.x = DASH_VELOCITY_ABS
	#elif (x_dir == 0): # straight up or down
		#if   y_dir == 1: # straight left
			#velocity.y = DASH_VELOCITY_ABS
		#elif y_dir == -1:
			#velocity.y = -1 * DASH_VELOCITY_ABS
	#elif (y_dir == 0): # straight ledt or right
		#if x_dir == 1: # straight left
			#velocity.x = DASH_VELOCITY_ABS
		#elif x_dir == -1:
			#velocity.x = -1 * DASH_VELOCITY_ABS
	#else:
		# PLACEHOLDER. here is the :( hard code. i dont like code.
		#velocity.y = y_dir * DASH_VELOCITY_ABS/2 
		#velocity.x = x_dir * DASH_VELOCITY_ABS/2
		
	

func move_around() -> void:
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func handle_dash(delta):
	curr_dash_len -= delta
	if (curr_dash_len <= 0): is_dashing = false;
	if (!test_move(Transform2D(0.0, position), Vector2(DASH_VELOCITY_ABS * dash_dir_x * delta,DASH_VELOCITY_ABS * dash_dir_y * delta))):
		position.x += DASH_VELOCITY_ABS * dash_dir_x * delta
		position.y += DASH_VELOCITY_ABS * dash_dir_y * delta
	
