class_name coin
extends RigidBody2D
@onready var anim = $AnimatedSprite2D
var timertest : float
signal sendPoints
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("Idle")
	#get_tree().create_timer(4).timeout
	timertest = 5;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#timertest -= 1 * delta
	#if timertest <= 0:
	#	$".."._despawn(self)
	#	timertest = 5
	#if anim.frame == 6:
	#	queue_free()
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
#	gravity_scale = 0
#	linear_velocity = Vector2.ZERO
#	anim.play("Picked")
	GlobalSignal.coin_score_update.emit()
	#$"../HUD".update_coins(1)
	$".."._on_collision(self)
	#This should work but it dosent
	#await anim.animation_finished
	#anim.animation_finished
	#queue_free()
