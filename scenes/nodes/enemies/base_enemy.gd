extends Node2D

@export var resource: EnemyRes

@onready var sprite: Sprite2D = $Sprite2D
@onready var movement: GridMovement2D = $GridMovement2D

var board: TileMap
var player: Player
var grid: AStarGrid2D
var current_id_path: Array[Vector2i]
var walkable_tiles: Array[Vector2i]


#region Godot Messages

func _ready():
	board = NodeProvider.get_board()
	player = NodeProvider.get_player()
	
	_init_grid()
	_init_enemy()
	_find_target()
	

func _process(delta):
	if (!movement.is_moving && !current_id_path.is_empty()):
		if (resource.strategy == Constants.Strategy.TARGET || resource.strategy == Constants.Strategy.FRONT):
			_find_target()
		
		var coord = board.local_to_map(global_position)
		var direction = current_id_path.front() - coord
		
		movement.find_next_position(direction)
		current_id_path.pop_front()
	
	if (!movement.is_moving && current_id_path.is_empty()):
		_find_target()
	

func _physics_process(delta):
	movement.move(delta)
	

#endregion

#region Implementation

func _init_enemy():
	sprite.texture = resource.sprite
	movement.set_speed(resource.speed)
	

func _init_grid():
	grid = AStarGrid2D.new()
	grid.region = board.get_used_rect()
	grid.cell_size = Vector2i(16, 16)
	grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	grid.update()
	
	var rect = board.get_used_rect()
	for x in rect.size.x:
		for y in rect.size.y:
			var tile = Vector2i(x + rect.position.x, y + rect.position.y)
			var data = board.get_cell_tile_data(0, tile)
			
			if (data.get_custom_data("Walkable") == false):
				grid.set_point_solid(tile)
			else:
				walkable_tiles.append(tile)
	

func _find_target():
	var target
	
	if (resource.strategy == Constants.Strategy.TARGET):
		target = player.global_position
	
	if (resource.strategy == Constants.Strategy.RANDOM):
		target = board.map_to_local(walkable_tiles.pick_random())
	
	if (resource.strategy == Constants.Strategy.FRONT):
		var player_coord = board.local_to_map(player.global_position)
		var front_coord = player_coord + (player.direction * 3)
		target = board.map_to_local(front_coord)
	
	var id_path = grid.get_id_path(
		board.local_to_map(global_position),
		board.local_to_map(target)
	).slice(1)
	
	if (!id_path.is_empty()):
		current_id_path = id_path
	

#endregion
