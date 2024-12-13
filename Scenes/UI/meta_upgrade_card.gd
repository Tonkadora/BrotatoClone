extends PanelContainer

signal selected

@onready var name_label = %NameLabel
@onready var description_label = %DescriptionLabel

var disabled: bool = false

func _ready():
	gui_input.connect(on_gui_input)
	mouse_entered.connect(on_mouse_entered)
	
func set_ameta_upgrade(upgrade: MetaUpgrade) -> void:
	name_label.text = upgrade.name
	description_label.text = upgrade.description


func select_card():
	disabled = true
	$AnimationPlayer.play("selected")

	
	
func on_gui_input(event: InputEvent) -> void:
	if disabled:
		return
		
	if event.is_action_pressed("left_click"):
		select_card()


func on_mouse_entered():
	if disabled:
		return
		
	$HoverAnimationPlayer.play("hover")
