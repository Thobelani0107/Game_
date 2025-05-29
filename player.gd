extends CharacterBody2D


@export var Speed :float =  200.0
@export var jump_velocity :float = -150.0
@export var double_jump_velocity : float =-300

var gravity= ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool=false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		has_double_jumped=true

	# Handle jump.
	if Input.is_action_just_pressed("jump"): 
		if is_on_floor():
			
			velocity.y = jump_velocity
		elif not has_double_jumped:
			velocity.y +=double_jump_velocity
			has_double_jumped=true
			
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * Speed
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)

	move_and_slide()
