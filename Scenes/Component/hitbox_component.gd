extends Area2D
class_name HitboxComponent

@export var health_component: HealthComponent


func _ready() -> void:
	area_entered.connect(on_area_entered)
	
	
func on_area_entered(area: Area2D) -> void:
	if not area is HurtboxComponent:
		return
		
	if health_component == null:
		return
	
	var hurtbox_component = area as HurtboxComponent
	health_component.damage(hurtbox_component.damage)
