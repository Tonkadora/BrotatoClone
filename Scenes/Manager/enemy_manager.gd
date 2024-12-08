extends Node

@export var basic_enemy_scene: PackedScene
@export var wizard_enemy_scene: PackedScene
@export var arena_time_manager: Node

const SPAWN_RADIUS: int = 375
var base_spawn_time: float

var enemy_table = WeightedTable.new()
@onready var timer: Timer = $Timer


func _ready() -> void:
	enemy_table.add_item(basic_enemy_scene, 10)
	base_spawn_time = timer.wait_time
	timer.timeout.connect(on_timer_timeout)
	arena_time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)
	

func get_spawn_position() -> Vector2:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return Vector2.ZERO
		
	var spawn_position = Vector2.ZERO
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	for i in 4:
		spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)

		var query_parameters = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1)
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)
		if result.is_empty(): 
			break
		else:
			random_direction = random_direction.rotated(deg_to_rad(90))
		
	return spawn_position
	
	
func on_timer_timeout() -> void:
	timer.start()
	#Spawn Enemy around the player
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var enemy_scene = enemy_table.pick_item()
	var enemy_instance = enemy_scene.instantiate() as Node2D
	
	var entites_layer = get_tree().get_first_node_in_group("entities_layer")
	entites_layer.add_child(enemy_instance)
	enemy_instance.global_position = get_spawn_position()


func on_arena_difficulty_increased(arena_difficulty: int) -> void:
	var time_off = (.1/12) * arena_difficulty
	time_off = min(time_off, .7)
	timer.wait_time = base_spawn_time - time_off
	
	if arena_difficulty == 6:
		enemy_table.add_item(wizard_enemy_scene, 20)
	
