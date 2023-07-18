extends Control

func _ready():
	$VBoxContainer/StartBtn.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/Tutorial.tscn")
	Global.number = 03

func _on_tutorial_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/Tutorial.tscn")
	Global.number = 02

func _on_quit_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/Tutorial.tscn")
	Global.number = 01
