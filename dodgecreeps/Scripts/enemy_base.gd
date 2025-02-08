class_name enemy_base

extends CharacterBody2D
var speed : float = 100
@export var enemy_stats : Resource
@export var pickup_scene : PackedScene

func _ready():
	set_modulate(enemy_stats.find_apparcence())
func _process(delta: float) -> void:
	velocity.x = enemy_stats.speed
	move_and_slide()
	if position.x > 1000:
		_respawn()
func _respawn():
	position = Vector2(-78, 123)


func _on_area_2d_area_entered(area: Area2D) -> void:
	GlobalSignal.asteroid_destroyed.emit(5)
	_respawn()
