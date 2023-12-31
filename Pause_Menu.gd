extends Control

var node = Node2D.new()
var body = RigidBody2D.new()
var collision = CollisionShape2D.new()

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused
		$CenterContainer/VBoxContainer/ResumeBtn.grab_focus()


var is_paused = false : 
	set(value):
		is_paused = value
		get_tree().paused = is_paused
		visible = is_paused



func _on_resume_btn_pressed():
	self.is_paused = false
	

func _on_quit_btn_pressed():
	get_tree().quit()
