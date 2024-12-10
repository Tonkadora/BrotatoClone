extends CharacterBody2D


@onready var visuals = $Visuals
@onready var velocity_component: Node = $VelocityComponent
@onready var hitbox_component = $HitboxComponent
@onready var random_stream_player_component = $HitRandomStreamPlayerComponent


func _ready():
	hitbox_component.hit.connect(on_hitbox_component_hit)
	

func _process(_delta: float) -> void:
	velocity_component.accelerate_to_player()
	velocity_component.move(self)

	var direction_sign = sign(velocity.x)
	if direction_sign != 0:
		visuals.scale.x = direction_sign

func on_hitbox_component_hit():
	random_stream_player_component.play_random()
