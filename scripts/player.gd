extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const GRAVITY = 1000
const FALL_GRAVITY = 1400
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


@onready var animated_sprite = $AnimatedSprite2D

func get_gravity(velocity: Vector2):
	if velocity.y < 0:
		return GRAVITY
	return FALL_GRAVITY

func _process(delta):

	if not is_on_floor():
		velocity.y += get_gravity(velocity) * delta

	# Handle jump.
	if Input.is_action_just_released("Jump") and velocity.y < 0:
		velocity.y = JUMP_VELOCITY / 4
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	
	
	#get input direction -1 0 or 1
	var direction = Input.get_axis("Move Left", "Move Right")
	
	#Flips Spirite based on direction
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	#Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")
	
	#Apply Movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	

