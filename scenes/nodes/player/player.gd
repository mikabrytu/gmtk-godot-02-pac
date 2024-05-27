extends Node2D

@export var speed: float

var board: TileMap
var direction: Vector2i
var previous_position: Vector2i
var target_position: Vector2i
var time: float
var can_move = true
var is_moving = false


#region Godot Messages

func _ready():
	board = NodeProvider.get_board()
	direction = Vector2i.RIGHT
	

func _process(delta):
	_check_direction()
	_get_next_position()
	_check_distance_to_target()
	

func _physics_process(delta):
	_move(delta)
	

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
	

func _get_next_position():
	if (is_moving): return
	
	var current_tile = board.local_to_map(global_position)
	var target_tile = current_tile + direction
	var tile_data = board.get_cell_tile_data(0, target_tile)
	
	can_move = tile_data.get_custom_data("Walkable")
	
	if (can_move):
		previous_position = global_position
		target_position = board.map_to_local(target_tile)
		is_moving = true
	else:
		is_moving = false
	

func _move(delta):
	if (!is_moving): return
	
	time += delta * speed
	global_position = Vector2(previous_position).lerp(target_position, time)
	

func _check_distance_to_target():
	if (Vector2i(global_position) == target_position):
		is_moving = false
		time = 0
	

#endregion
