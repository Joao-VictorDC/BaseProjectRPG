extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func _tile_data_runtime_update(layer: int, coords: Vector2i, tile_data: TileData) -> void: tile_data.set_collision_polygons_count(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		get_node("arvores_mortas").hide()
		get_node("arvore_limpa").show()
		_tile_data_runtime_update(0, ,)
		
