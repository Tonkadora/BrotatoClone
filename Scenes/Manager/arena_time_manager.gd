extends Node

signal arena_difficulty_increased(arena_difficulty: int)

@export var end_screen_scene: PackedScene

const DIFFICULTY_INTERVAL = 5

var arena_difficulty: int = 0

@onready var timer: Timer = $Timer


func _ready():
	timer.timeout.connect(on_timer_timeout)
	

func _process(delta):
	var next_time_target = timer.wait_time - ((arena_difficulty + 1) * DIFFICULTY_INTERVAL)
	if timer.time_left <= next_time_target:
		arena_difficulty += 1
		arena_difficulty_increased.emit(arena_difficulty)
		
		
func get_time_elapsed():
	return timer.wait_time - timer.time_left


func on_timer_timeout() -> void:
	var end_screen = end_screen_scene.instantiate()
	add_child(end_screen)
	end_screen.play_jingle()
	MetaProgression.save()
