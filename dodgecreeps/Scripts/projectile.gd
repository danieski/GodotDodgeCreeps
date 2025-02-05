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


func _on_area_2d_body_entered(body: Node2D) -> void:
	get_tree().current_scene.get_node("HUD")._on_main_hit(5)
	$CPUParticles2D.emitting=true
	
	if body.is_in_group("enemy"):
		body._respawn()
	else:
		body.queue_free()
	#queue_free()
	
	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	#GlobalSignal.bullet_exit_screen.emit(self)
	$"../Player"._on_screen_exited(self)
