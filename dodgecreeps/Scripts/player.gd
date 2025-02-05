extends Area2D

var screen_size # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size

	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
