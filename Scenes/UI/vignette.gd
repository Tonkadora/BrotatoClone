extends CanvasLayer


func _ready():
	GameEvents.player_damgaed.connect(on_player_damaged)
	

func on_player_damaged() -> void:
	$AnimationPlayer.play("hit")
