extends Node2D
class_name HammerAbility

var elapsed = 0
var range: int
var base_rotation: Vector2
var base_speed: float
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent


func _process(delta: float) -> void:
	spin()
	rotate_in_direction()
	
func rotate_in_direction():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	var rotate_angle = (player.global_position - global_position).angle()
	rotation = rotate_angle
	
	
func spin():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	elapsed += get_process_delta_time()
	var speed = elapsed * base_speed
	var current_direction = base_rotation.rotated(deg_to_rad(speed))
	global_position = player.global_position + (current_direction * range)
