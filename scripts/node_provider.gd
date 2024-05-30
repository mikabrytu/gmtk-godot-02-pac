extends Node

var board: TileMap
var player: Player

func register(node: Node2D):
	if (node is TileMap):
		board = node
	
	if (node is Player):
		player = node
	

func get_board():
	if (board == null):
		_print_node_missing("Board (TileMap)")
		return
	
	return board
	

func get_player():
	if (player == null):
		_print_node_missing("Player")
		return
	
	return player
	

func _print_node_missing(name: String):
	printerr(name + " node was not registered")
	
