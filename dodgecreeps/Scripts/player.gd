extends Area2D
#const bullePath = preload("res://Resource/bullet_base.tscn")
@export var speed = 600 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size
	
func shoot():
	#var bullet = bullePath.instantiate()
	 #get_parent().add_child(bullet)
	#bullet.position = $Node2D/Marker2D.global_position
	pass
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		rotation += 1 * delta
	if Input.is_action_pressed("move_left"):
		rotation -= 1 * delta
	if Input.is_action_just_pressed("shoot"):
		shoot()
	#if Input.is_action_pressed("move_up"):
	#	velocity.y -= 10




	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)






	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
