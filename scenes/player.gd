extends Node
class_name player


var player_name:String = "Default"
var max_health:int = 100
var health:int = max_health
var shifts:int = 0
var defence:int = 0
var resistances:Dictionary = {}
var status:Dictionary = {}

func setup(info:Dictionary) -> void:
	self.max_health = info["max_health"]
	self.health = info["health"]
	
	

func start_turn() -> void:
	if health == 0:
		GlobalSignalBus.emit_player_death()

func defend(shield:int)->void:
	defence += shield

func get_damage_multiplier(type:String) -> float:
	if type in resistances.keys():
		return resistances[type]/100
	else:
		return 1

func take_damage(incoming_damage:Damage)->void:
	var damage:int = roundi(incoming_damage.damage * get_damage_multiplier(incoming_damage.type))
	if damage < defence:
		defence -= damage
		return
	var current_damage = damage - defence
	defence = 0
	if current_damage >= health:
		health = 0
		return
	health -= current_damage

func heal(heal_amount:int)->void:
	if health + heal_amount > max_health:
		health = max_health
	else:
		health += heal_amount

func export() -> Dictionary:
	return {"health":health}
