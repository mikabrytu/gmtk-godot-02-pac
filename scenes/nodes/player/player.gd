extends Area2D

@export var speed: float
@export var initial_path: PathFollow2D

@onready var ray = $RayCast2D as RayCast2D

var direction: Vector2i
var path: PathFollow2D

#region Godot Messages

func _ready():
	direction = Vector2i.RIGHT
	
	_set_path(initial_path, 0)
	path.progress_ratio = 0.5
	

func _physics_process(delta):
	var direction = _get_direction()
	var axis = direction.x if direction.x != 0 else direction.y
	path.progress += axis * speed * delta
	

#endregion

#region Implementation

func _set_path(new_path, old_position):
	if (new_path != null && new_path is PathFollow2D):
		path = new_path
		
		if (old_position != 0):
			path.progress = old_position - path.position.y
		
		reparent.call_deferred(path)
	

func _get_direction() -> Vector2i:
	if (Input.is_action_just_pressed("action_up")):
		direction = Vector2i.UP
	
	if (Input.is_action_just_pressed("action_down")):
		_find_new_path()
		direction = Vector2i.DOWN
	
	if (Input.is_action_just_pressed("action_left")):
		direction = Vector2i.LEFT
	
	if (Input.is_action_just_pressed("action_right")):
		direction = Vector2i.RIGHT
	
	return direction
	

func _find_new_path():
	if (ray.is_colliding()):
		var parent: Path2D = ray.get_collider().get_parent()
		_set_path(parent.get_node("PathFollow2D"), path.position.y)

#endregion
