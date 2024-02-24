extends KinematicBody2D

var velocity = Vector2(0.4, 1)
var speed = 90

func _ready():
	add_to_group('asteroid')

func _physics_process(delta: float) -> void:
	#global_position += velocity * speed * delta
	
	var collision = move_and_collide(velocity * delta * speed)
