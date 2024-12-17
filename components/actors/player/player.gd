extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var health = 3 
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var sprint = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#toggle sprint
	if Input.is_action_just_pressed("sprint"):
		sprint = not sprint 

	if Input.is_action_just_pressed("roll"):
		roll()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if sprint:
			velocity.x *= 2
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func roll():
	animated_sprite_2d.play("roll")
