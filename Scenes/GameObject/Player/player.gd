extends CharacterBody2D

const MAX_SPEED: float = 125
const ACCELERATION_SMOOTHING: int = 25

func _process(delta: float) -> void:
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	var tartget_velocity = direction * MAX_SPEED
	velocity = velocity.lerp(tartget_velocity, 1.0 - (exp(-delta * ACCELERATION_SMOOTHING)))
	move_and_slide()
	

func get_movement_vector() -> Vector2:
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)
