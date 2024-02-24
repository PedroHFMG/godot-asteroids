extends KinematicBody2D

var speed = 15
var velocity = Vector2(0, -1)

func _ready():
	add_to_group('bullet')

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * speed * delta)
	
	if position.y < 0:
		queue_free()

	if position.x < 0:
		queue_free()

	if position.y > 480:
		queue_free()
		
	if position.x > 640:
		queue_free()
	
	#Detecta o objeto que o raycast da bala colidiu
	var obj = $RayCast2D.get_collider()
	
	#Deleta a bala, e o objeto que a bala colidiiu
	if $RayCast2D.is_colliding():
		obj.queue_free()
		queue_free()
