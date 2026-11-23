extends CharacterBody2D

@export var speed: float = 300.0
@export var gravity: float = 980.0
@export var jump_velocity: float = -450.0
@export var acceleration: float = 1800.0
@export var friction: float = 1800.0
@export var fall_multiplier: float = 2.0
var jumps = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var directionX: float = Input.get_axis("move_left", "move_right")
	if directionX != 0:
		velocity.x = move_toward(velocity.x, directionX*speed, acceleration*delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, friction*delta)

	if not is_on_floor():
		if velocity.y > 0:
			velocity.y += (gravity * fall_multiplier * delta)
		else:
			velocity.y += (gravity * delta)
		
	if is_on_floor():
		jumps = 2
		
	if Input.is_action_just_pressed("jump") and jumps > 0:
		jumps -= 1
		velocity.y = jump_velocity
	
	if Input.is_action_just_released("jump") and velocity.y < 0:
			velocity.y*=0.5
		
	move_and_slide()
