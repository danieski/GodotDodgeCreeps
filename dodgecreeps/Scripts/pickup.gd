class_name coin
extends RigidBody2D
@onready var anim = $AnimatedSprite2D

signal sendPoints
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	anim.play("Idle")



func _on_area_2d_area_entered(area: Area2D) -> void:
	GlobalSignal.coin_obtained.emit(self)
