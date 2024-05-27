extends Node

var board: TileMap

func register(node: Node2D):
	if (node is TileMap):
		board = node
	

func get_board():
	if (board == null):
		printerr("Board node was not registered")
		return
	
	return board
