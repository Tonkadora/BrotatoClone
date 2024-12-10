extends CanvasLayer

@onready var end_screen_card = $MarginContainer/EndScreenCard



func _ready():
	end_screen_card.defeated.connect(on_defeated)
	get_tree().paused = true
	

func play_jingle(defeat: bool = false):
	if defeat:
		$DefeatStreamPlayer.play()
	else:
		$VictoryStreamPlayer.play()

func on_defeated():
	play_jingle(true)
