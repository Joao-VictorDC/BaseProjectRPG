extends Control

# Chamado quando o nó entra na árvore de cena pela primeira vez.
func _ready():
	#Mantém o foco inicial no botão, para selecioná-los com as setas do teclado
	$VBoxContainer/StartBtn.grab_focus()
	


# Chamado cada quadro. 'delta' é o tempo decorrido desde o quadro anterior.
func _process(delta):
	pass

# Função chamada quando o botão de Iniciar é apertado
func _on_start_btn_pressed():
	# Altera a cena para a tela de escolha da dificuldade do jogo
	get_tree().change_scene_to_file("res://scenes/Dificulty.tscn")

# Função chamada quando o botão de Sair é apertado
func _on_tutorial_btn_pressed():
	#Sai do jogo
	get_tree().quit()



