extends Node
var score =0
@export var mob_scene: PackedScene
@export var SuperMob_scene: Resource
@export var coin_scene: PackedScene
@onready var _scree_size : Rect2 = get_viewport().get_visible_rect()
#signal hit   
var _pool : Pool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()
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
	
	_despawn(coinSpawned)
	remove_child(coinSpawned)
	_spawn_coin()
	
func _despawn(coinSpawned : coin) -> void:
	_pool.return_element(coinSpawned)
	
func new_game():
	
	get_tree().call_group("mobs", "queue_free")
	$StartTimer.start()
	$HUD.update_score(0)
	$"HUD/Game Timer".start(20)
	$HUD.show_message("Get Ready")	
	


func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)


func _on_enemy_timer_timeout() -> void:
	#wadd_child(SuperMob_scene.instantate())
	
	pass # Replace with function body.
