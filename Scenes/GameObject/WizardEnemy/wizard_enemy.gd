extends CharacterBody2D

var is_moving = false

@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var visuals: Node2D = $Visuals
@onready var hitbox_component = $HitboxComponent
@onready var hit_random_stream_player_component = $HitRandomStreamPlayerComponent


func _ready():
	hitbox_component.hit.connect(on_hitbox_component_hit)
func _process(delta: float) -> void:
	if is_moving:
		velocity_component.accelerate_to_player()
	else:
		velocity_component.decelerate()
	velocity_component.move(self)
	
	var direction_sign = sign(velocity.x)
	if direction_sign != 0:
		visuals.scale.x = direction_sign


func set_is_moving(moving: bool):
	is_moving = moving


func on_hitbox_component_hit():
	hit_random_stream_player_component.play_random()
