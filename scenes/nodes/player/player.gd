extends Area2D

@export var speed: float
@export var initial_path: PathFollow2D

@onready var up_ray = $"Ray Group/Up Ray" as RayCast2D
@onready var down_ray = $"Ray Group/Down Ray" as RayCast2D
@onready var left_ray = $"Ray Group/Left Ray" as RayCast2D
@onready var right_ray = $"Ray Group/Right Ray" as RayCast2D

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

func _set_path(new_path, progress):
	var old_path: PathFollow2D = path
	
	path = new_path
	path.progress = progress
	reparent.call_deferred(path)
	
	if (old_path != null):
		old_path.set_progress.call_deferred(0)
	

func _get_direction() -> Vector2i:
	if (Input.is_action_just_pressed("action_up")):
		direction = Vector2i.UP
		_find_new_path(direction, up_ray)
	
	if (Input.is_action_just_pressed("action_down")):
		direction = Vector2i.DOWN
		_find_new_path(direction, down_ray)
	
	if (Input.is_action_just_pressed("action_left")):
		direction = Vector2i.LEFT
		_find_new_path(direction, left_ray)
	
	if (Input.is_action_just_pressed("action_right")):
		direction = Vector2i.RIGHT
		_find_new_path(direction, right_ray)
	
	return direction
	

func _find_new_path(direction, ray):
	if (ray.is_colliding()):
		print("Ray is colliding with " + ray.get_collider().name)
		
		var parent: Path2D = ray.get_collider().get_parent()
		var new_path = parent.get_node("PathFollow2D")
		var progress = 0
		
		if (new_path == null || !new_path is PathFollow2D): 
			return
		
		if (direction == Vector2i.DOWN || direction == Vector2i.UP):
			progress = path.position.y - new_path.position.y
		
		if (direction == Vector2i.LEFT || direction == Vector2i.RIGHT):
			var current_path_x = path.position.x
			var new_path_x = new_path.position.x
			var d = current_path_x - new_path_x
			
			print("Current Path X: " + str(current_path_x))
			print("New Path X: " + str(new_path_x))
			print("Progess: " + str(d))
			
			progress = path.position.x - new_path.position.x
		
		_set_path(new_path, progress)

#endregion
