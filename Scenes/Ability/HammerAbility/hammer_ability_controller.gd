extends Node

@export var hammer_ability_scene: PackedScene

var speed = 10
var range = 50
var number_of_hammers = 5


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
		var spawn_angle = Vector2.RIGHT.rotated(increment_angle * i)
		var offset = spawn_angle * range
		hammer_ability.global_position = player.global_position + offset
