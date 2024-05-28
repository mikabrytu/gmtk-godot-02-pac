extends Node2D

@export var coin: PackedScene

var board: TileMap


#region Godot Messages

func _ready():
	board = NodeProvider.get_board()
	
	_spawn_coins()
	

#endregion

#region Implementation

func _spawn_coins():
	var tiles = board.get_used_cells(0)
	
	for t in tiles:
		var data = board.get_cell_tile_data(0, t)
		if (data.get_custom_data("Walkable") == true):
			var clone = coin.instantiate()
			clone.global_position = board.map_to_local(t)
			
			self.add_child(clone)
	

#endregion
