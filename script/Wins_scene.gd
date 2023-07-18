extends Control


# Chamado quando o nó entra na árvore de cena pela primeira vez.
func _ready():
	# Mantém o foco inicial no botão, para selecioná-los com as setas do teclado
	$VBoxContainer/Play_Again.grab_focus()

# Chamado cada quadro. 'delta' é o tempo decorrido desde o quadro anterior.
func _process(delta):
	pass


# Função chamada ao apertar o botão de jogar novamente 
func _on_play_again_pressed():
	# Altera a cena para a principal (onde ocorre o jogo)
	get_tree().change_scene_to_file("res://scenes/Main_Level.tscn")


# Função chamada ao apertar o botão de Voltar
func _on_back_menu_pressed():
	# Altera a cena para o menu inicial
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


# Função chamada ao apertar o botão de Sair
func _on_quit_btn_pressed():
	# Fecha a execução do jogo
	get_tree().quit()
