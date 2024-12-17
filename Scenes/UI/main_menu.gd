extends CanvasLayer

const OPTIONS = preload("res://Scenes/UI/options.tscn")
const META_MENU = preload("res://Scenes/UI/meta_menu.tscn")
@onready var play_button = %PlayButton
@onready var options_button = %OptionsButton
@onready var quit_button = %QuitButton
@onready var upgrade_button: Button = %UpgradeButton

func _ready():
	play_button.pressed.connect(on_play_pressed)
	options_button.pressed.connect(on_options_pressed)
	upgrade_button.pressed.connect(on_upgrades_pressed)
	quit_button.pressed.connect(on_quit_pressed)
	
	

func on_play_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	get_tree().change_scene_to_file("res://Scenes/Main/main.tscn")
	
	
func on_options_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	var options_instance = OPTIONS.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(on_options_closed.bind(options_instance))
 

func on_options_closed(options_instance: Node) -> void:
	options_instance.queue_free()
	

func on_upgrades_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	var meta_menu = META_MENU.instantiate()
	add_child(meta_menu)

	
	
func on_quit_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	get_tree().quit()
