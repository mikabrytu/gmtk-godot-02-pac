extends Node2D

@export var speed: float
@export var direction: Vector2i


func _process(delta):
	position += direction * speed
