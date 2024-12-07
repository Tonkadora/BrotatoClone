extends CharacterBody2D

const MAX_SPEED: float = 125
const ACCELERATION_SMOOTHING: int = 25

var number_of_enemies = 0

@onready var collision_area_2d = $CollisionArea2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var dmg_interval_timer = $DmgIntervalTimer
@onready var health_bar = $HealthBar
@onready var abilities = $Abilities
@onready var animation_player = $AnimationPlayer
@onready var visuals = $Visuals



func _ready():
	update_health_display()
	collision_area_2d.body_entered.connect(on_body_entered)
	collision_area_2d.body_exited.connect(on_body_exited)
	dmg_interval_timer.timeout.connect(on_dmg_interval_timer_timeout)
	health_component.health_changed.connect(on_health_changed)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	
	
func _process(delta: float) -> void:
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	var tartget_velocity = direction * MAX_SPEED
	velocity = velocity.lerp(tartget_velocity, 1.0 - (exp(-delta * ACCELERATION_SMOOTHING)))
	move_and_slide()
	if movement_vector.x != 0 or movement_vector.y != 0:
		animation_player.play("walk")
	else:
		animation_player.play("RESET")
	
	var move_sign = sign(movement_vector.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)
		

func get_movement_vector() -> Vector2:
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)


func check_deal_damage() -> void:
	if number_of_enemies == 0 || !dmg_interval_timer.is_stopped():
		return
	
	health_component.damage(1)
	dmg_interval_timer.start()
		

func update_health_display() -> void:
	health_bar.value = health_component.get_health_percent()
	
	
func on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("enemy"):
		return
	number_of_enemies += 1
	check_deal_damage()


func on_body_exited(body: Node2D) -> void:
	if not body.is_in_group("enemy"):
		return
		
	number_of_enemies -= 1
	

func on_dmg_interval_timer_timeout() -> void:
	check_deal_damage()


func on_health_changed() -> void:
	update_health_display()


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	if not upgrade is Ability:
		return
		
	
	var ability = upgrade as Ability
	abilities.add_child(ability.ability_controller_scene.instantiate())
