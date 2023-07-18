extends Control


# Chamado quando o nó entra na árvore de cena pela primeira vez.
func _ready():
	# Mantém o foco inicial no botão, para selecioná-los com as setas do teclado
	$HBoxContainer/Back_Button.grab_focus()
	

# Chamado cada quadro. 'delta' é o tempo decorrido desde o quadro anterior.
func _process(delta):
	pass


# Função chamada quando o botão de iniciar é apertado
func _on_play_button_pressed():
	# Altera a cena para a principal (onde ocorre o jogo)
	get_tree().change_scene_to_file("res://scenes/Main_Level.tscn")


# Função chamada quando o botão de voltar é apertado
func _on_back_button_pressed():
	# Altera a cena para o menu inicial
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
