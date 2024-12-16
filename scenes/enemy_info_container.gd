extends VBoxContainer

@onready var portrait: TextureRect = $VBoxContainer/HBoxContainer/portrait
@onready var enemy_name: Label = $VBoxContainer/HBoxContainer/enemy_name
@onready var health_bar: ProgressBar = $VBoxContainer/health_bar
@onready var status_effects: Label = $VBoxContainer/status_effects
@onready var health_label: Label = $VBoxContainer/health_label
@onready var effects_info: Label = $VBoxContainer/effects_info


func update(enemy:Monster) -> void:
	health_bar.max_value = enemy.health.max_health
	health_bar.value = enemy.health.health
	set_statuses(enemy.status)
	enemy_name.text = enemy.monster_name
	health_label.text = "HP: " + str(enemy.health.health)+" / " + str(enemy.health.max_health)
	effects_info.text = ""
	for effect in enemy.status:
		effects_info.text += effect + ": " + str(enemy.status[effect]) + "\n"

func set_statuses(statuses:Dictionary) -> void:
	status_effects.text = ""
	for item in statuses.keys():
		status_effects.text += item + ": " + str(statuses[item]) + " "
