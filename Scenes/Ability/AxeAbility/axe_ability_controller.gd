extends Node

@export var axe_ability_scene: PackedScene

var base_damage = 10
var additional_damage_percent: float = 1

@onready var timer = $Timer


func _ready():
	timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	
	
func on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
		
	var foreground = get_tree().get_first_node_in_group("foreground_layer") as Node2D
	if foreground == null:
		return
		
	var axe_ability = axe_ability_scene.instantiate() as Node2D
	foreground.add_child(axe_ability)
	
	axe_ability.hurtbox_component.damage = base_damage * additional_damage_percent
	axe_ability.global_position = player.global_position
	
	
func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	if upgrade.id == "axe_damage":
		print("more axe damage")
		additional_damage_percent = 1 + (current_upgrades["axe_damage"]["quantity"] * .1)
