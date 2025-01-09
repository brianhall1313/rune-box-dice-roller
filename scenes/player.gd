extends Node
class_name player

@onready var health: Health = $Health

var player_name:String = "Default"
var shifts:int = 0
var status:Dictionary = {}

signal defense_gone
signal took_damage

func setup(info) -> void:
	health.setup(info["max_health"],info["health"])

func start_turn() -> void:
	countdown_status()
	if health.defense > 0:
		defense_gone.emit()
	health.reset_defense()
	if health.health == 0:
		GlobalSignalBus.emit_player_death()

func defend(shield:int) -> void:
	health.defend(shield)

func countdown_status() -> void:
	#print("status")
	for effect in status.keys():
		if StatusManager.countdown.keys().has(effect):
			StatusManager.countdown[effect].call(self)


func take_damage(incomming_damage:Damage,direct:bool=false) -> void:
	var pre_damage_health:int = health.health
	health.take_damage(incomming_damage,direct)
	if health.defense == 0:
		defense_gone.emit()
	if pre_damage_health != health.health:
		took_damage.emit()

func heal(heal_amount:int) -> void:
	health.heal(heal_amount)

func export() -> Dictionary:
	return {"health":health.health}
