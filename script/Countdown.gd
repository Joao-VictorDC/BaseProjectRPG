extends Label

var seconds: int = 01
var minutes: int = 01

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_2_timeout():
	seconds -= 1
	set_text(str(str(minutes).pad_zeros(2), " : ", str(seconds).pad_zeros(2)))
	if seconds == 0:
		seconds = 60
		minutes -= 1
	if minutes < 0:
		get_tree().change_scene_to_file("res://scenes/Lose_scene.tscn")
