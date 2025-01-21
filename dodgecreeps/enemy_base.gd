extends CharacterBody2D
@export var enemytype : Resource

func _process(delta):
	position.x += enemytype.speed * delta
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
func getScore():
	return 5
