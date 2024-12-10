extends PanelContainer

signal defeated

@onready var restart_button = %RestartButton
@onready var quit_button = %QuitButton
@onready var title_label = %TitleLabel
@onready var description_label = %DescriptionLabel
@onready var animation_player = $AnimationPlayer

func _ready():
	restart_button.pressed.connect(on_restart_button_pressed)
	quit_button.pressed.connect(on_quit_button_pressed)
	

func set_defeat() -> void:
	title_label.text = "Defeat"
	description_label.text = "You Lost"
	defeated.emit()
	
func on_restart_button_pressed() -> void:
	get_tree().paused = false
	animation_player.play("selected")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://Scenes/Main/main.tscn")
	
	
func on_quit_button_pressed() -> void:
	animation_player.play("discarded")
	await animation_player.animation_finished
	get_tree().quit()
