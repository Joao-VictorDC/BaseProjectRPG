extends CharacterBody2D

@export_category("Objects")
@export var anim: AnimatedSprite2D = null

@export_category("Variables")
@export var max_speed = 75
@export var accel = 600
@export var friction = 600

var input = Vector2.ZERO


func _physics_process(delta):
	player_moviment(delta)
	updateAnimation()
	
func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()
	
func player_moviment(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else: 
			velocity = Vector2.ZERO
	else: 
		velocity += (input * accel * delta) 
		velocity = velocity.limit_length(max_speed)
		
	move_and_slide()

func updateAnimation():
	var state = "Idle"
	
	if velocity.lengt() > 10:
		state = "Walk"
	if velocity.length() == 0:
		state = "Idle"
		
	if velocity.x > 0 and velocity.y == 0:
		anim.play(state+ "Right")
	if velocity.x < 0 and velocity.y == 0:
		anim.play(state+ "Left")
	if velocity.y > 0 and velocity.x == 0:
		anim.play(state+ "Down")
	if velocity.y < 0 and velocity.x == 0:
		anim.play(state+ "Up")
	if velocity.x > 0 and velocity.y != 0:
		anim.play(state+ "Right")
	if velocity.x < 0 and velocity.y != 0:
		anim.play(state+ "Left")
