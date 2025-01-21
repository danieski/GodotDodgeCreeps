extends Area2D

@export var speed = 600 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		rotation += 1 * delta
	if Input.is_action_pressed("move_left"):
		rotation -= 1 * delta
	if Input.is_action_just_pressed("shoot"):
		print("test")
	#if Input.is_action_pressed("move_up"):
	#	velocity.y -= 10





	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)






	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
