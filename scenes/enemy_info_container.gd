extends VBoxContainer

@onready var portrait: TextureRect = $VBoxContainer/HBoxContainer/portrait
@onready var enemy_name: Label = $VBoxContainer/HBoxContainer/enemy_name
@onready var health_bar: ProgressBar = $VBoxContainer/health_bar
@onready var status_effects: Label = $VBoxContainer/status_effects


func update(enemy:Monster) -> void:
	health_bar.max_value = enemy.health.max_health
	health_bar.value = enemy.health.health
	set_statuses(enemy.status_effects)
	enemy_name.text = enemy.monster_name

func set_statuses(statuses:Array[Dictionary]) -> void:
	status_effects.text = ""
	for item in statuses:
		status_effects.text += item["name"] #TODO add a number for strength or duration
