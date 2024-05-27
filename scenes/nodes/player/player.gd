extends Node2D

var board: TileMap
var direction: Vector2i
var can_move = true


#region Godot Messages

func _ready():
	board = NodeProvider.get_board()
	direction = Vector2i.RIGHT
	

func _process(delta):
	_check_direction()
	_move()
	

#endregion

#region Implementation

func _check_direction():
	if (Input.is_action_just_pressed("up")):
		direction = Vector2i.UP
	if (Input.is_action_just_pressed("down")):
		direction = Vector2i.DOWN
	if (Input.is_action_just_pressed("left")):
		direction = Vector2i.LEFT
	if (Input.is_action_just_pressed("right")):
		direction = Vector2i.RIGHT
	

func _move():
	var current_tile = board.local_to_map(global_position)
	var target_tile = current_tile + direction
	var tile_data = board.get_cell_tile_data(0, target_tile)
	
	can_move = tile_data.get_custom_data("Walkable")
	
	if (can_move):
		global_position = board.map_to_local(target_tile)
	

#endregion
