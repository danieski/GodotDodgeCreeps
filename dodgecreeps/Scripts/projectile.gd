class_name bullet
extends CharacterBody2D
@export var SPEED = 500
var dir : float
var spawnPos : Vector2
var spawnRot : float


func _ready():
	
	global_position = spawnPos
	global_rotation = spawnRot
	
func _physics_process(delta):
	velocity = Vector2(0,-SPEED).rotated(dir)
	move_and_slide()
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
