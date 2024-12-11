extends Node

@export var experience_manager: Node
@export var upgrade_screen_scene: PackedScene

const UPGRADE_AXE = preload("res://Resources/Upgrades/axe.tres")
const UPGRADE_AXE_DAMAGE = preload("res://Resources/Upgrades/axe_damage.tres")
const UPGRADE_SWORD_DAMAGE = preload("res://Resources/Upgrades/sword_damage.tres")
const UPGRADE_SWORD_RATE = preload("res://Resources/Upgrades/sword_rate.tres")
const UPGRADE_PLAYER_SPEED = preload("res://Resources/Upgrades/player_speed.tres")
const UPGRADE_HAMMER = preload("res://Resources/Upgrades/hammer.tres")

var current_upgrades: Dictionary = {}
var upgrade_pool:WeightedTable = WeightedTable.new()


func _ready() -> void:
	upgrade_pool.add_item(UPGRADE_AXE, 10)
	upgrade_pool.add_item(UPGRADE_SWORD_RATE, 10)
	upgrade_pool.add_item(UPGRADE_SWORD_DAMAGE, 10)
	upgrade_pool.add_item(UPGRADE_HAMMER, 10000)
	upgrade_pool.add_item(UPGRADE_PLAYER_SPEED, 5)
	experience_manager.leveled_up.connect(on_leveled_up)
	
	
func pick_upgrades() -> Array[AbilityUpgrade]:
	var chosen_upgrades: Array[AbilityUpgrade] = []

	
	for i in 2:
		if upgrade_pool.items.size() == chosen_upgrades.size():
			break
		var chosen_upgrade = upgrade_pool.pick_item(chosen_upgrades)
		chosen_upgrades.append(chosen_upgrade)
	return chosen_upgrades
	
	
func apply_upgrade(upgrade: AbilityUpgrade) -> void:
	var has_upgrade = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
	
	
	if upgrade.max_quantity > 0:
		var current_quantity = current_upgrades[upgrade.id]["quantity"]
		if current_quantity == upgrade.max_quantity:
			upgrade_pool.remove_item(upgrade)

	
	update_upgrade_pool(upgrade)		
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


func update_upgrade_pool(chosen_upgrade: AbilityUpgrade) -> void:
	if chosen_upgrade.id == UPGRADE_AXE.id:
		upgrade_pool.add_item(UPGRADE_AXE_DAMAGE, 10)
		
		
func on_leveled_up(level:int) -> void:
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	var chosen_upgrades = pick_upgrades()
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)
	
	
		
func on_upgrade_selected(upgrade: AbilityUpgrade) -> void:
	apply_upgrade(upgrade)
