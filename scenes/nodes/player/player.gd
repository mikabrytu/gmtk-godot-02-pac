extends Node2D

@onready var grid_movement: GridMovement2D = $GridMovement2D

var direction: Vector2i


#region Godot Messages

func _ready():
	direction = Vector2i.RIGHT
	

func _process(delta):
	_get_direction()
	grid_movement.find_next_position(direction)
	

func _physics_process(delta):
	grid_movement.move(delta)
	

#endregion

#region Implementation

func _get_direction():
	if (Input.is_action_just_pressed("up")):
		direction = Vector2i.UP
	if (Input.is_action_just_pressed("down")):
		direction = Vector2i.DOWN
	if (Input.is_action_just_pressed("left")):
		direction = Vector2i.LEFT
	if (Input.is_action_just_pressed("right")):
		direction = Vector2i.RIGHT
	

#endregion
