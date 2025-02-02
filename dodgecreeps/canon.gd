extends Node2D

@onready var main = get_tree().get_root().get_node("Main")
@onready var projectile = load("res://Scenes/projectile.tscn")
# Called when the node enters the scene tree for the first time.


func shoot():
	var instance = projectile.instantiate()
	instance.dir = rotation
	instance.spawnPos = global_position
	instance.spawnRot = global_rotation
	main.add_child.call_deferred(instance)
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_left"):
		rotation -= 10 *delta;
	if Input.is_action_pressed("move_right"):
		rotation += 10 *delta;
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Collision wiuth player")
