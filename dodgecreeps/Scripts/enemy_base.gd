extends CharacterBody2D
var speed : float = 100
@export var enemy_stats : Resource

func _ready():

	set_modulate(enemy_stats.find_apparcence())
func _process(delta: float) -> void:
	velocity.x = enemy_stats.speed
	move_and_slide()
