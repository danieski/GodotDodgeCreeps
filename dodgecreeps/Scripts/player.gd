class_name Player
extends Node2D

@onready var main = get_tree().get_root().get_node("Main")
@export var projectile: PackedScene
var can_interact : bool

func _ready() -> void:
	GlobalSignal.game_on_hud.connect(_player_ready)
	GlobalSignal.game_off_hud.connect(_player_not_ready)
	_player_not_ready()
func _player_not_ready():
	
	$".".hide()
	can_interact = false
	
func _player_ready():
	
	$".".show()
	can_interact = true
	
func shoot():
	
	var instance = projectile.instantiate()
	instance.dir = rotation + 83.3
	instance.spawnPos = global_position
	instance.spawnRot = global_rotation
	main.add_child.call_deferred(instance)
	
func _physics_process(delta: float) -> void:
	if can_interact:
		look_at(get_global_mouse_position())
		if Input.is_action_pressed("move_left"):
			position.x -= 150 * delta;
		if Input.is_action_pressed("move_right"):
			position.x += 150 * delta;
		if Input.is_action_pressed("move_up"):
			position.y -= 150 * delta;
		if Input.is_action_pressed("move_down"):
			position.y += 150 * delta;
		if Input.is_action_just_pressed("shoot"):
			shoot()
