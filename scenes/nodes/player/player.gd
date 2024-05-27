extends Node2D

var board: TileMap
var direction: Vector2i


#region Godot Messages

func _ready():
	board = NodeProvider.get_board()
	

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
	
	print(str(current_tile) + " | " + str(target_tile))
	

#endregion
