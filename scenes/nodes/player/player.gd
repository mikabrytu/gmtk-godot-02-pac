extends Area2D

@export var speed: float
@export var server_path: PathFollow2D

var direction: Vector2i
var path: PathFollow2D

#region Godot Messages

func _ready():
	direction = Vector2i.RIGHT
	
	_set_path()
	path.progress_ratio = 0.5
	reparent.call_deferred(path)
	

func _process(delta):
	path.progress += _get_direction().x * speed * delta
	

#endregion

#region Implementation

func _set_path():
	path = server_path
	

func _get_direction() -> Vector2i:
	if (Input.is_action_just_pressed("action_up")):
		direction = Vector2i.UP
	if (Input.is_action_just_pressed("action_down")):
		direction = Vector2i.DOWN
	if (Input.is_action_just_pressed("action_left")):
		direction = Vector2i.LEFT
	if (Input.is_action_just_pressed("action_right")):
		direction = Vector2i.RIGHT
	
	return direction
	

#endregion
