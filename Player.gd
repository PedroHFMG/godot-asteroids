extends KinematicBody2D

var speed = 225
var accel = 8
var rotate_speed = 2.5
var rotate_dir = 0
var velocity = Vector2()
onready var screen = get_viewport_rect().size
const bullet = preload("res://bullet.tscn")

func getinput():
	#Se a tecla de rotacionar é pressionada (0 p/ não, ou 1 p/ sim)
	rotate_dir = 0
	
	if Input.is_action_pressed("fire") and $Timer.is_stopped():
		shoot()
	if Input.is_action_pressed("p1_right"):
		rotate_dir += 1
	if Input.is_action_pressed("p1_left"):
		rotate_dir -= 1
		
	#Comando de ir pra frente/trás. Possui aceleração linear (move_toward) e a função de rotação (rotated.rotation)
	#rotation pega automaticamente o quanto o Node girou
	if Input.is_action_pressed("p1_up"):
		velocity = velocity.move_toward(Vector2(0, -speed).rotated(rotation), accel)
	elif Input.is_action_pressed("p1_down"):
		velocity = velocity.move_toward(Vector2(0, speed).rotated(rotation), accel)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, accel)
	if Input.is_action_pressed("p1_down"):
		velocity = velocity.move_toward(Vector2(0, speed).rotated(rotation), accel)

func _physics_process(delta: float) -> void:
	getinput()
	rotation += rotate_dir * rotate_speed * delta
	velocity = move_and_slide(velocity)
	screenwrap()

func screenwrap():
	if position.x > screen.x:
		position.x = 0
		
	if position.x < 0:
		position.x = screen.x
	
	if position.y > screen.y:
		position.y = 0
		
	if position.y < 0:
		position.y = screen.y

func shoot():
	#Timer pra evitar spam de projéteis
	$Timer.start()
	
	var bala = bullet.instance()
	get_parent().add_child(bala)
	
	#Ajusta a rotação da bala (o raycast aponta para onde a nave girou)
	bala.global_rotation = global_rotation
	
	#Posição pra instanciar a bala
	bala.position = $Position2D.global_position
	
	#Vetor com a direção de onde a nave está apontando, para a bala também seguir nessa direção
	bala.velocity = $Position2D.global_position - position
