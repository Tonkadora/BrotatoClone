extends Node

@export var axe_ability_scene: PackedScene

var damage = 10

@onready var timer = $Timer


func _ready():
	timer.timeout.connect(on_timer_timeout)
	
	
	
func on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
		
	var foreground = get_tree().get_first_node_in_group("foreground_layer") as Node2D
	if foreground == null:
		return
		
	var axe_ability = axe_ability_scene.instantiate() as Node2D
	foreground.add_child(axe_ability)
	
	axe_ability.hurtbox_component.damage = damage
	axe_ability.global_position = player.global_position
	
