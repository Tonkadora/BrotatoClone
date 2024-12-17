extends CanvasLayer

@export var upgrades: Array[MetaUpgrade] = []

const META_UPGRADE_CARD = preload("res://Scenes/UI/meta_upgrade_card.tscn")

@onready var grid_container: GridContainer = $VScrollBar/MarginContainer/GridContainer
@onready var back_button: Button = %BackButton

func _ready() -> void:
	back_button.pressed.connect(on_back_pressed)
	for child in grid_container.get_children():
		child.queue_free()
		
	for upgrade in upgrades:
		var meta_upgrade_card = META_UPGRADE_CARD.instantiate()
		grid_container.add_child(meta_upgrade_card)
		meta_upgrade_card.set_meta_upgrade(upgrade)


func on_back_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	queue_free()
