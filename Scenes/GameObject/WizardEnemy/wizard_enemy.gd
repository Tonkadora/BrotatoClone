extends CharacterBody2D

var is_moving = false

@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var visuals: Node2D = $Visuals

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
