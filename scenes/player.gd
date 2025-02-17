extends Node
class_name player

@onready var health: Health = $Health

var player_name:String = "Default"
var shifts:int = 0
var max_shifts:int = 3
var status:Dictionary = {}

signal defense_gone
signal took_damage(damage:Damage)

func setup(info) -> void:
	health.setup(info["max_health"],info["health"])

func start_turn() -> void:
	countdown_status()
	if health.defense > 0:
		defense_gone.emit()
	health.reset_defense()
	if health.health == 0:
		GlobalSignalBus.emit_player_death()
	set_shifts()

func defend(shield:int) -> void:
	health.defend(shield)

func countdown_status() -> void:
	#print("status")
	for effect in status.keys():
		if StatusManager.countdown.keys().has(effect):
			StatusManager.countdown[effect].call(self)
			if StatusManager.effects_list.keys().has(effect):
				GlobalSignalBus.emit_add_effect(StatusManager.effects_list[effect],self)


func take_damage(incomming_damage:Damage,direct:bool=false) -> void:
	var pre_damage_health:int = health.health
	health.take_damage(incomming_damage,direct)
	if health.defense == 0:
		defense_gone.emit()
	if pre_damage_health != health.health:
		var d = Damage.new(pre_damage_health-health.health,incomming_damage.type)
		took_damage.emit(d)
	else:
		var d = Damage.new(0,incomming_damage.type)
		took_damage.emit(d)

func heal(heal_amount:int) -> void:
	health.heal(heal_amount)

func export() -> Dictionary:
	return {"health":health.health}

func spend_shift() -> void:
	shifts -= 1

func can_spend_shift() -> bool:
	if shifts > 0:
		return true
	return false

func get_bonus_shifts() -> int:
	var bonus:int = 0
	#TODO bonus logic
	if Global.debug:
		bonus = 99
	return bonus

func set_shifts() -> void:
	shifts =  max_shifts + get_bonus_shifts()
