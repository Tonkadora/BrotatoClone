extends Node

const PAUSE_MENU = preload("res://Scenes/UI/pause_menu.tscn")

@export var end_screen_scene: PackedScene

@onready var player = %Player

func _ready():
	player.health_component.died.connect(on_player_died)


func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		var pause_menu_instance = PAUSE_MENU.instantiate()
		add_child(pause_menu_instance)
		get_tree().root.set_input_as_handled()
		
		
func on_player_died() -> void:
	var end_screen = end_screen_scene.instantiate()
	add_child(end_screen)
	end_screen.end_screen_card.set_defeat()
