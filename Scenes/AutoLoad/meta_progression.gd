extends Node

const SAVE_FILE_PATH = "user://game.save"
var save_data: Dictionary = {
	"win_count": 0,
	"loss_count": 0,
	"upgrade_currency": 0,
	"upgrades":{}
}

func _ready():
	GameEvents.experience_vial_collected.connect(on_experience_vial_collected)
	load_save_file()

	
func load_save_file():
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		return
		
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	save_data = file.get_var()
	
	
func save():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(save_data)
	
	
func add_meta_upgrade(upgrade: MetaUpgrade):
	if ! save_data["upgrades"].has(upgrade.id):
		save_data["upgrades"][upgrade.id] = {"quantity": 0}
		
	save_data["upgrades"][upgrade.id]["quantity"] += 1
	save()


func get_upgrade_count(upgrade_id: String):
	if save_data["upgrades"].has(upgrade_id):
		return save_data["upgrades"][upgrade_id]["quantity"]
	return 0
	
		
func on_experience_vial_collected(number: float):
	save_data["upgrade_currency"] += number
