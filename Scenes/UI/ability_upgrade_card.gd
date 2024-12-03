extends PanelContainer

signal selected

@onready var name_label = %NameLabel
@onready var description_label = %DescriptionLabel

func _ready():
	gui_input.connect(on_gui_input)
	
	
func set_ability_upgrade(ability_upgrade: AbilityUpgrade) -> void:
	name_label.text = ability_upgrade.name
	description_label.text = ability_upgrade.description


func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		selected.emit()
