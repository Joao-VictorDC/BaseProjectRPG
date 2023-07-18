extends CharacterBody2D
# Código não utilizado no jogo.
var selected = false

func _on_area_2d_input_event(viewport, event, shape_idx):
	if !Input.is_action_pressed("click"):
		selected = false
	else:
		selected = true
func _physics_process(delta):
	if selected: 
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
