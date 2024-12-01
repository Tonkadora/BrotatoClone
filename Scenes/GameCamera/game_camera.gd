extends Camera2D

var target_position: Vector2 = Vector2.ZERO


func _ready() -> void:
	make_current()
	
func _process(delta: float) -> void:
	acquire_target()
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 10))
		 
func acquire_target() -> void:
	var player_node = get_tree().get_first_node_in_group("player")
	if player_node != null:
		var player = player_node as Node2D
		target_position = player.global_position
