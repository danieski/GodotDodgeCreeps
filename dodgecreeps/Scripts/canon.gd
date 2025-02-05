extends Node2D

@onready var main = get_tree().get_root().get_node("Main")
@onready var projectile = load("res://Scenes/projectile.tscn")
@onready 
# Called when the node enters the scene tree for the first time.
var _pool : Pool
var tempAux : float
var shootingAviable : bool
func _ready() -> void:
	#Creamos pool
	_pool = Pool.new()
	_pool.initialize(projectile, 10)
	#GlobalSignal.bullet_exit_screen.connect(_on_screen_exited)
func _process(delta: float) -> void:
	
	pass
func _spawn_bullet():
	#Configuramos la nueva instancia
	var bulletSpawned : bullet = _pool.get_element() as bullet
	bulletSpawned.dir = rotation
	bulletSpawned.spawnPos = global_position
	bulletSpawned.spawnRot = global_rotation
	main.add_child.call_deferred(bulletSpawned)
	
	#_on_screen_exited(bulletSpawned)
func _on_screen_exited(bulletSpawned):
	#La devolvemos en la pool cuando sale de la pantalla
	_pool.return_element(bulletSpawned)
	get_parent().remove_child(bulletSpawned)
	print("Devuelto")

func _despawn(bulletSpawned : bullet) -> void:
	_pool.return_element(bulletSpawned)
#func shoot():
	
#	var instance = projectile.instantiate()
#	instance.dir = rotation
#	instance.spawnPos = global_position
#	instance.spawnRot = global_rotation
#	main.add_child.call_deferred(instance)
	
func _physics_process(delta: float) -> void:
	
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("move_left"):
		position.y -= 150 * delta;
	if Input.is_action_pressed("move_right"):
		position.y += 150 * delta;
	if Input.is_action_pressed("move_up"):
		position.x += 150 * delta;
	if Input.is_action_pressed("move_down"):
		position.x -= 150 * delta;
		
	if Input.is_action_just_pressed("shoot"):
		_spawn_bullet()


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass
