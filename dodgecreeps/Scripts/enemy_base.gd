class_name enemy_base

extends CharacterBody2D
var speed : float = 100
@export var enemy_stats : Resource
@export var pickup_scene : PackedScene

func _ready():
	#pass
	set_modulate(enemy_stats.find_apparcence())
func _process(delta: float) -> void:
	velocity.x = enemy_stats.speed
	move_and_slide()
	if position.x > 1000:
		_respawn()
func _respawn():
	#var pickup = pickup_scene.instantiate()
	#pickup.position = position
	#get_parent().add_child(pickup)
	position = Vector2(-78, 123)
