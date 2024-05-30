class_name GridMovement2D extends Node2D

@export var speed: float

var board: TileMap
var parent: Node2D
var previous_position: Vector2i
var target_position: Vector2i
var time: float
var can_move = true
var is_moving = false

#region Godot Messages

func _ready():
	board = NodeProvider.get_board()
	parent = get_parent()
	

func _process(delta):
	_check_distance_to_target()
	

#endregion

#region Implementation

func _check_distance_to_target():
	if (Vector2i(parent.global_position) == target_position):
		is_moving = false
		time = 0
	

#endregion

#region Public API

func find_next_position(direction: Vector2i):
	if (is_moving): return
	
	var current_tile = board.local_to_map(parent.global_position)
	var target_tile = current_tile + direction
	var tile_data = board.get_cell_tile_data(0, target_tile)
	var can_move = tile_data.get_custom_data("Walkable")
	
	if (can_move):
		previous_position = parent.global_position
		target_position = board.map_to_local(target_tile)
		is_moving = true
	else:
		is_moving = false
	

func move(delta):
	if (!is_moving): return
	
	time += delta * speed
	parent.global_position = Vector2(previous_position).lerp(target_position, time)
	

func set_speed(speed: float):
	self.speed = speed
	

#endregion
