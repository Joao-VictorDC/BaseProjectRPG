extends CharacterBody2D

@export_category("Objects")
@export var anim: AnimatedSprite2D = null

@export_category("Variables")
@export var max_speed = 75
@export var accel = 600
@export var friction = 600

@onready var all_interactions = []
@onready var interaction_label = $Interaction_Component/InteractionLabel

var task: int = 0

var input = Vector2.ZERO

# Chamado quando o nó entra na árvore de cena pela primeira vez.
func _ready():
	update_interactions()
	
# Chamado cada quadro. 'delta' é o tempo decorrido desde o quadro anterior. Nesse caso excepcional, aborda a física do jogo
func _physics_process(delta):
	player_moviment(delta)
	updateAnimation()
	
	#Verifica se o botão interact (E) foi pressionado
	if Input.is_action_just_pressed("interact"):
		#Chama a função para executar a interação duas vezes, uma para deletar o estado inicial, outra para tornar visível o estado final
		execute_interaction()
		execute_interaction()
	
	#Verifica o progresso das tasks e altera para a página de vitória do jogo	
	if task >= 100:
		get_tree().change_scene_to_file("res://scenes/Wins_scene.tscn")
	
#A função get_input serve para indicar ao código se o personagem irá para direita ou esquerda, para cima ou para baixo. Valores positivos no input indicam que o personagem irá para direita ou para cima. valores negativos indicam que o personagem irá para baixo ou esquerda.
func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()

#A funcção player_moviment serve para dar movimento ao personagem, armazenado o valor da tecla pressionada na variável input.
func player_moviment(delta):
	input = get_input()
	
	# Verifica o valor do input para saber se devemos acelerar o personagem ou não.
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else: 
			velocity = Vector2.ZERO
	else: 
		velocity += (input * accel * delta) 
		velocity = velocity.limit_length(max_speed)
		
	# Chama o método para mover o personagem
	move_and_slide()

#A função updateAnimation serve para dar animação ao personagem, atualizando os seus sprites conforme seu movimento
func updateAnimation():
	#Verifica se o personagem está em movimento
	if velocity.length() > 20:
		anim.play("Walk")
		if velocity.x > 0:
			anim.flip_h = false
		if velocity.x < 0:
			anim. flip_h = true
	else:
		anim.play("Idle")
		

# Função para verificar se um determinado objeto entrou na área especificada
func _on_interaction_area_area_entered(area):
	all_interactions.insert(0, area)
	# Chama a função para atualizar o texto da interação
	update_interactions() 


# Função para verificar se um determinado objeto saiu na área especificada
func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
		# Chama a função para atualizar o texto da interação
	update_interactions()
	

# Funão para atualizar o texto da interação conforme a entrada ou saída da área.
func update_interactions():
	# Verifica se alguma das interações são verdadeiras
	if all_interactions:
		interaction_label.text = all_interactions[0].interact_label
	else:
		interaction_label.text = ""
		
	
# Função para executar o bloco de código que ocorrerá após pressionado a tecla para interagir
func execute_interaction():
	if all_interactions:
		var cur_interacion = all_interactions[0]
		cur_interacion.interact_value = cur_interacion.interact_value + 1
		# Deleta os sprites que antecedem a interação
		if cur_interacion.interact_value == 1:
			get_parent().get_node("Objects/"+cur_interacion.interact_name+"/after").queue_free()
			
		# Insere os sprites que aparecerão após a interação
		if cur_interacion.interact_value == 2:
			get_parent().get_node("Objects/"+cur_interacion.interact_name+"/before").show()
			# Indica a porcentagem que a conclusão de cada atividade representa na barra de progresso
			task += 18
			$ProgressBar.value = task
			
		# Verifica o tipo da interação e permite que seja alterada a cena caso necessário
		match cur_interacion.interact_type:
			"growth_tree" : pass
			"recycle_bin" : pass

