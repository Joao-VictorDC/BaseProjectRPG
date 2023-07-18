extends Label

#Variavei que armazenam o tempo
var seconds: int = 01
var minutes: int = Global.number

# Chamado quando o nó entra na árvore de cena pela primeira vez.
func _ready():
	pass


# Chamado cada quadro. 'delta' é o tempo decorrido desde o quadro anterior.
func _process(delta):
	pass


func _on_timer_2_timeout():
	seconds -= 1
	#Escreve o texto na Label formatado
	set_text(str(str(minutes).pad_zeros(2), " : ", str(seconds).pad_zeros(2)))
	#Lógica para criar um tempo regressivo
	if seconds == 0:
		seconds = 60
		minutes -= 1
	if minutes < 0:
		# Altera para a cena de derrota
		get_tree().change_scene_to_file("res://scenes/Lose_scene.tscn")
