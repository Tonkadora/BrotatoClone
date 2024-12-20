extends PanelContainer

signal selected

@onready var name_label = %NameLabel
@onready var description_label = %DescriptionLabel

var disabled: bool = false
func _ready():
	gui_input.connect(on_gui_input)
	mouse_entered.connect(on_mouse_entered)
	
func set_ability_upgrade(ability_upgrade: AbilityUpgrade) -> void:
	name_label.text = ability_upgrade.name
	description_label.text = ability_upgrade.description


func play_in(delay: float = 0):
	modulate = Color.TRANSPARENT
	await get_tree().create_timer(delay).timeout
	$AnimationPlayer.play("in")
	
	
func play_discard():
	$AnimationPlayer.play("discarded")
	

func select_card():
	disabled = true
	$AnimationPlayer.play("selected")
	for other_card in get_tree().get_nodes_in_group("upgrade_card"):
		if other_card == self:
			continue
		other_card.play_discard()
	await $AnimationPlayer.animation_finished
	selected.emit()
	
	
func on_gui_input(event: InputEvent) -> void:
	if disabled:
		return
		
	if event.is_action_pressed("left_click"):
		select_card()


func on_mouse_entered():
	if disabled:
		return
		
	$HoverAnimationPlayer.play("hover")
