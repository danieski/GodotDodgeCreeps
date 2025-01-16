extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).
#@export var shoot_scene: PackedScene
var screen_size # Size of the game window.
func _ready():
	screen_size = get_viewport_rect().size
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if $"../Reload".time_left == 0:
		if Input.is_action_just_pressed("shoot"):
			$"../Reload".start()
			var tween = get_tree().create_tween()
			
			
			twinaux(tween)
			tween.set_parallel(false)
			tween.tween_property($"../Sprite2D","position",Vector2(-8,-8),0)
			tween.tween_property($"../Sprite2D","scale",Vector2(1,1 ),0)

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		





func twinaux(tween):
	tween.set_parallel()
	tween.tween_property($"../Sprite2D","scale",Vector2(0.3,0.3),1)
	tween.tween_property($"../Sprite2D","position",position,1)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
