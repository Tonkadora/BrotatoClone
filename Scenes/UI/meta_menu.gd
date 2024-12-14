extends CanvasLayer

@export var upgrades: Array[MetaUpgrade] = []

const META_UPGRADE_CARD = preload("res://Scenes/UI/meta_upgrade_card.tscn")

@onready var grid_container: GridContainer = $MarginContainer/GridContainer

func _ready() -> void:
	for upgrade in upgrades:
		var meta_upgrade_card = META_UPGRADE_CARD.instantiate()
		grid_container.add_child(meta_upgrade_card)
		meta_upgrade_card.set_meta_upgrade(upgrade)
