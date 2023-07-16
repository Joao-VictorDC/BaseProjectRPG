extends CharacterBody2D

@export_category("Objects")
@export var anim: AnimatedSprite2D = null

@export_category("Variables")
@export var max_speed = 75
@export var accel = 600
@export var friction = 600
@export var max_task: int = 0

@onready var all_interactions = []
@onready var interaction_label = $Interaction_Component/InteractionLabel

var task: int = 0

var input = Vector2.ZERO

func _ready():
	$Task_number.text = str("Atividades concluídas: ", str(task).pad_zeros(2), "/"+str(max_task).pad_zeros(2))
	update_interactions()
	

func _physics_process(delta):
	player_moviment(delta)
	updateAnimation()
	
	if Input.is_action_just_pressed("interact"):
		execute_interaction()
		execute_interaction()
		
	if task == max_task:
		get_tree().change_scene_to_file("res://scenes/Wins_scene.tscn")
	
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
	if velocity.length() > 20:
		anim.play("Walk")
		if velocity.x > 0:
			anim.flip_h = false
		if velocity.x < 0:
			anim. flip_h = true
	else:
		anim.play("Idle")
		

func _on_interaction_area_area_entered(area):
	all_interactions.insert(0, area)
	update_interactions() 


func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()
	

func update_interactions():
	if all_interactions:
		interaction_label.text = all_interactions[0].interact_label
	else:
		interaction_label.text = ""
		
	
func execute_interaction():
	if all_interactions:
		var cur_interacion = all_interactions[0]
		cur_interacion.interact_value = cur_interacion.interact_value + 1
		if cur_interacion.interact_value == 1:
			get_parent().get_node("Objects/"+cur_interacion.interact_name+"/after").queue_free()
			
		if cur_interacion.interact_value == 2:
			get_parent().get_node("Objects/"+cur_interacion.interact_name+"/before").show()
			task += 1
			
		match cur_interacion.interact_type:
			"growth_tree" : pass
		$Task_number.text = str("Atividades concluídas: ", str(task).pad_zeros(2), "/"+str(max_task).pad_zeros(2))

