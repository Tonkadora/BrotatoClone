extends Node

@export var hammer_ability_scene: PackedScene

var base_speed = 100
var range = 50
var number_of_hammers = 5
var damage = 1


func _ready():
	spawn_hammers()
	

func clear_hammers():
	var hammers = get_tree().get_nodes_in_group("hammer_ability")
	if hammers == []:
		return
	for hammer in hammers:
		hammer.queue_free()
		
		
func spawn_hammers():
	clear_hammers()
		
	for i in number_of_hammers:
		var hammer_ability = hammer_ability_scene.instantiate()
		var foreground = get_tree().get_first_node_in_group("foreground_layer")
		if foreground == null:
			return
		
		var player = get_tree().get_first_node_in_group("player") as Node2D
		if player == null:
			return
			
		foreground.add_child(hammer_ability)
		
		var increment_angle = deg_to_rad((360 / (number_of_hammers)))
		var base_rotation = Vector2.RIGHT.rotated(increment_angle * i)
		var offset = base_rotation * range
		hammer_ability.global_position = player.global_position + offset
		hammer_ability.range = range
		hammer_ability.base_rotation = base_rotation
		hammer_ability.base_speed = base_speed
		hammer_ability.rotate_in_direction()
		
		Callable(apply_damage_to_hurtbox.bind(hammer_ability)).call_deferred()
		
func apply_damage_to_hurtbox(hammer_ability: HammerAbility):
	hammer_ability.hurtbox_component.damage = damage
	


func _on_timer_timeout() -> void:
	base_speed += 5
