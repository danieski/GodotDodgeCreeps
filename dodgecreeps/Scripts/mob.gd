extends RigidBody2D
@export var enemy_stats: Resource


func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	GlobalSignal.asteroid_destroyed.emit(1)
	$CPUParticles2D.emitting = true
	await $CPUParticles2D.finished
	queue_free()
