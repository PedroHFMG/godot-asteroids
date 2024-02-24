extends Node2D

const asteroide_big = preload("res://asteroid_big.tscn")

func _ready():
	$Timer.start() # Replace with function body.

func _physics_process(delta):
	pass


func _on_Timer_timeout():
	var ast_big = asteroide_big.instance()
	
	var ast_big_loc = get_node("Path2D/PathFollow2D")
	ast_big_loc.offset = randi()
	
	var direction = ast_big_loc.rotation + PI / 2

	
	get_parent().add_child(ast_big)
