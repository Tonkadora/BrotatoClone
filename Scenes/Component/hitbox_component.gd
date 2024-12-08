extends Area2D
class_name HitboxComponent

@export var health_component: HealthComponent

const FLOATING_TEXT_SCENE = preload("res://Scenes/UI/floating_text.tscn")


func _ready() -> void:
	area_entered.connect(on_area_entered)
	
	
func on_area_entered(area: Area2D) -> void:
	if not area is HurtboxComponent:
		return
		
	if health_component == null:
		return
	
	var hurtbox_component = area as HurtboxComponent
	health_component.damage(hurtbox_component.damage)
	
	var floating_text = FLOATING_TEXT_SCENE.instantiate() as Node2D
	get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text)
	floating_text.global_position = global_position + (Vector2.UP * 16)
	
	var format_string = "%0.1f"
	if round(hurtbox_component.damage) == hurtbox_component.damage:
		format_string = "%0.0f"
	floating_text.start(str(format_string % hurtbox_component.damage))
	
