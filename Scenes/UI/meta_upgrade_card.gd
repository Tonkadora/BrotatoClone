extends PanelContainer


var upgrade: MetaUpgrade 

@onready var name_label = %NameLabel
@onready var description_label = %DescriptionLabel
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var purchase_button: Button = %PurchaseButton
@onready var progress_label: Label = %ProgressLabel
@onready var count_label: Label = %CountLabel


func _ready():
	purchase_button.pressed.connect(on_purchase_pressed)
	
func set_meta_upgrade(upgrade: MetaUpgrade) -> void:
	self.upgrade = upgrade
	name_label.text = upgrade.title
	description_label.text = upgrade.description
	update_progress()
	

func update_progress():
	var currency = MetaProgression.save_data["upgrade_currency"]
	var percent = currency / upgrade.experience_cost
	percent = min(percent, 1)
	progress_bar.value = percent
	purchase_button.disabled = percent < 1
	progress_label.text = str(currency) + "/" + str(upgrade.experience_cost)
	count_label.text = "x%d" % MetaProgression.save_data["upgrades"][upgrade.id]["quantity"]
	
func select_card():
	$AnimationPlayer.play("selected")

	
func on_purchase_pressed():
	if upgrade == null:
		return
	
	MetaProgression.add_meta_upgrade(upgrade)
	MetaProgression.save_data["upgrade_currency"] -= upgrade.experience_cost
	MetaProgression.save()
	get_tree().call_group("meta_upgrade_card", "update_progress")
	select_card()
