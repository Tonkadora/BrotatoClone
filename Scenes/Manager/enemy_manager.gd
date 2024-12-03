extends Node

@export var basic_enemy_scene: PackedScene
@export var arena_time_manager: Node

const SPAWN_RADIUS: int = 375

var base_spawn_time: float
@onready var timer: Timer = $Timer


func _ready() -> void:
	base_spawn_time = timer.wait_time
	timer.timeout.connect(on_timer_timeout)
	arena_time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)
	
	
func on_timer_timeout() -> void:
	timer.start()
	#Spawn Enemy around the player
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spwan_position = player.global_position + (random_direction * SPAWN_RADIUS)
	var enemy_instance = basic_enemy_scene.instantiate() as Node2D
	
	var entites_layer = get_tree().get_first_node_in_group("entities_layer")
	entites_layer.add_child(enemy_instance)
	enemy_instance.global_position = spwan_position


func on_arena_difficulty_increased(arena_difficulty: int) -> void:
	var time_off = (.1/12) * arena_difficulty
	time_off = min(time_off, .7)
	timer.wait_time = base_spawn_time - time_off
	print(time_off)
