extends Node
class_name player

@onready var health: Health = $Health

var player_name:String = "Default"
var shifts:int = 0
var status:Dictionary = {}

func setup(info) -> void:
	health.setup(info["max_health"],info["health"])

func start_turn() -> void:
	update_status()
	health.reset_defense()
	if health.health == 0:
		GlobalSignalBus.emit_player_death()

func defend(shield:int) -> void:
	health.defend(shield)

func update_status() -> void:
	print("status")
	for effect in status.keys():
		if StatusManager.status_directory.keys().has(effect):
			StatusManager.status_directory[effect].call(self)

func add_effect(effect_name:String, effect_value:int) -> void:
	if status.keys().has(effect_name):
		status[effect_name] += effect_value
		return
	status[effect_name] = effect_value
	

func take_damage(incomming_damage:Damage,direct:bool=false) -> void:
	health.take_damage(incomming_damage,direct)

func export() -> Dictionary:
	return {"health":health.health}
