extends CharacterBody2D

@export var player = CharacterBody2D
@export var stats: EnemyBase = preload("res://components/actors/enemies/enemie_library/zombie.tres")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

enum {
	IDLE,
	NEAR,
	IN_RANGE,
	ATTACK,
	HIT
}

var state = IDLE
var idle_move_target : Vector2 = Vector2.ZERO
var incrementer : int = 0
var just_hit = false 


func _physics_process(delta):
	match state:
		IDLE:
			idle_move(delta)
		#NEAR:
			#move_towards_player(player)
			#move()
		#IN_RANGE:
		#ATTACK:
		#HIT:



func getRandomNumBetween(low, high):
	return randi_range(low, high)


func idle_move(delta):
#	towards a position until it matches
#	wait a bit
#	pick a new position

	if global_position != idle_move_target:
		var newXPos = getRandomNumBetween(global_position.x - 125, global_position.x + 125)
		idle_move_target = Vector2(newXPos, global_position.y)
		if incrementer == 100:
			print(idle_move_target, global_position)
			incrementer = 0
		incrementer += 1
		var direction = idle_move_target
		var desired_velocity = Vector2(direction.x * SPEED, direction.y).normalized()
		velocity = desired_velocity
		move_and_slide()

func move_towards_player(target, delta):
	var direction = (target - global_position).normalized()
	var desired_velocity = direction * SPEED
	var steering = (desired_velocity - velocity) * delta * 2.5
	velocity += steering
	move_and_slide()


func _on_hit_box_area_entered(area: Area2D) -> void:
	if not just_hit:
		stats.health -= 5 
		print("im hoit -- ", stats.health)
		just_hit = true
		await get_tree().create_timer(1).timeout
		print("done")
		just_hit = false
