extends Node2D

@export var speed: float

var direction: Vector2i


func _ready():
	direction = Vector2i.RIGHT
	

func _process(delta):
	_get_direction()
	position += direction * speed
	

func _get_direction():
	if (Input.is_action_just_pressed("action_up")):
		direction = Vector2i.UP
	if (Input.is_action_just_pressed("action_down")):
		direction = Vector2i.DOWN
	if (Input.is_action_just_pressed("action_left")):
		direction = Vector2i.LEFT
	if (Input.is_action_just_pressed("action_right")):
		direction = Vector2i.RIGHT
	
