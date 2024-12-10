extends Node2D
class_name HammerAbility


@onready var hurtbox_component = $HurtboxComponent


func spin():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	var rotate_angle = (global_position - player.global_position).angle()
	rotate(rotate_angle)
	
