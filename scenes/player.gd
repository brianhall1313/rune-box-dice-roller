extends Node
class_name player

@onready var health: Health = $Health

var player_name:String = "Default"
var shifts:int = 0
var status:Dictionary = {"poison":3}

func setup(info) -> void:
	health.setup(info["max_health"],info["health"])

func start_turn() -> void:
	update_status()
	health.reset_defense()
	if health.health == 0:
		GlobalSignalBus.emit_player_death()

func update_status() -> void:
	print("status")
	for effect in status.keys():
		if StatusManager.status_directory.keys().has(effect):
			StatusManager.status_directory[effect].call(self)

func take_damage(incomming_damage:Damage,direct:bool=false) -> void:
	health.take_damage(incomming_damage,direct)

func export() -> Dictionary:
	return {"health":health.health}
