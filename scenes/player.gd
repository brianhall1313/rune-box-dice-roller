extends Node
class_name player


var player_name:String = "Default"
var max_health:int = 100
var health:int = max_health
var shifts:int = 0
var defense:int = 0
var resistances:Dictionary = {}
var status:Dictionary = {}

func setup(info:Dictionary) -> void:
	self.max_health = info["max_health"]
	self.health = info["health"]
	
	

func start_turn() -> void:
	if health == 0:
		GlobalSignalBus.emit_player_death()

func defend(shield:int)->void:
	defense += shield

func get_damage_multiplier(type:String) -> float:
	if type in resistances.keys():
		return resistances[type]/100.0
	else:
		return 1.0

func take_damage(incoming_damage:Damage)->void:
	var multiplier: float = get_damage_multiplier(incoming_damage.type)
	#print("multiplier for damage is: ",multiplier)
	var damage = roundi(incoming_damage.damage * multiplier)
	#print("my damage taken is ",damage, " of the type: ",incoming_damage.type)
	if damage < defense:
		defense -= damage
		return
	var current_damage = damage - defense
	defense = 0
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
