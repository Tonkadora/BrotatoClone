extends Node

@export var basic_enemy_scene: PackedScene

const SPAWN_RADIUS: int = 375

@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)
	
	
func on_timer_timeout() -> void:
	#Spawn Enemy around the player
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spwan_position = player.global_position + (random_direction * SPAWN_RADIUS)
	var enemy_instance = basic_enemy_scene.instantiate() as Node2D
	get_parent().add_child(enemy_instance)
	enemy_instance.global_position = spwan_position
