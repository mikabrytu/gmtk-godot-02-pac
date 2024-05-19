extends CharacterBody2D

@export var speed: float

@onready var ray_group = $"Ray Group"

var direction: Vector2i


func _ready():
	direction = Vector2i.RIGHT
	

func _process(delta):
	if (_can_change_direction()):
		velocity = direction * speed
	

func _physics_process(delta):
	move_and_slide()
	

func _can_change_direction() -> bool:
	var d = direction
	
	if (Input.is_action_just_pressed("action_up")):
		ray_group.rotation_degrees = -90
		d = Vector2i.UP
	
	if (Input.is_action_just_pressed("action_down")):
		ray_group.rotation_degrees = 90
		d = Vector2i.DOWN
	
	if (Input.is_action_just_pressed("action_left")):
		ray_group.rotation_degrees = 180
		d = Vector2i.LEFT
	
	if (Input.is_action_just_pressed("action_right")):
		ray_group.rotation_degrees = 0
		d = Vector2i.RIGHT
	
	if (ray_group.get_node("Up Ray").is_colliding()):
		print("Up ray is colliding | Group Ray Rotation: " + str(ray_group.rotation) + " | Real direction: " + str(direction))
		return false
	
	if (ray_group.get_node("Bottom Ray").is_colliding()):
		print("Bottom ray is colliding | Cached Direction: " + str(d) + " | Real direction: " + str(direction))
		return false
	
	direction = d
	return true
