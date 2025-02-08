extends Node
var score =0
@export var mob_scene: PackedScene
@export var coin_scene: PackedScene
@export var super_mob_scene: PackedScene
@onready var _scree_size : Rect2 = get_viewport().get_visible_rect()

var _pool : Pool

func _ready() -> void:
	
	GlobalSignal.coin_obtained.connect(_on_collision)
	_pool = Pool.new()
	_pool.initialize(coin_scene, 10)
	_spawn_coin()

	
func _spawn_coin():

	await get_tree().create_timer(1).timeout
	var coinSpawned : coin = _pool.get_element() as coin
	var base_y : float = _scree_size.position.y + _scree_size.size.y*0.3
	coinSpawned.position.x = randf_range(_scree_size.position.x, _scree_size.position.x + _scree_size.size.x * 0.8)
	coinSpawned.position.y = randf_range(base_y, base_y + _scree_size.size.y * 0.6)
	add_child(coinSpawned)


func _on_collision(coinSpawned : coin):
	
	_pool.return_element(coinSpawned)
	remove_child(coinSpawned)
	_spawn_coin()

	
func new_game():
	
	get_tree().call_group("mobs", "queue_free")
	$StartTimer.start()
	$HUD.update_score(0)
	%"Game Timer".start(20)
func _spawner_mobs(instancia : Node):
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	instancia.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	instancia.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	instancia.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(instancia)



func _on_mob_timer_timeout():

	var mob = mob_scene.instantiate()

	_spawner_mobs(mob)
	



func _on_super_mob_timer_timeout() -> void:
	var super_mob = super_mob_scene.instantiate()

	_spawner_mobs(super_mob)
