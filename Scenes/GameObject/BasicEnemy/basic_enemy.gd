extends CharacterBody2D


@onready var visuals = $Visuals
@onready var velocity_component: Node = $VelocityComponent


func _process(_delta: float) -> void:
	velocity_component.accelerate_to_player()
	velocity_component.move(self)

	var direction_sign = sign(velocity.x)
	if direction_sign != 0:
		visuals.scale.x = direction_sign
