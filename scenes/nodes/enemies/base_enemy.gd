extends Node2D

@export var resource: EnemyRes

@onready var sprite: Sprite2D = $Sprite2D
@onready var grid_movement: GridMovement2D = $GridMovement2D


#region Godot Messages

func _ready():
	sprite.texture = resource.sprite
	

func _process(delta):
	grid_movement.find_next_position(Vector2i.RIGHT)
	

func _physics_process(delta):
	grid_movement.move(delta)

#endregion
