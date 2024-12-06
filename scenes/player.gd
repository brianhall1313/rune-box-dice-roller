extends Node
class_name player


var player_name:String = "Default"
var max_health:int = 100
var health:int = max_health
var shifts:int = 0
var defense:int = 0
var resistances:Dictionary = {}
var status:Dictionary = {"poison":3}

func setup(info:Dictionary) -> void:
	self.max_health = info["max_health"]
	self.health = info["health"]
	
	

func start_turn() -> void:
	update_status()
	defense = 0
	if health == 0:
		GlobalSignalBus.emit_player_death()

func update_status() -> void:
	print("status")
	for effect in status.keys():
		if StatusManager.status_directory.keys().has(effect):
			StatusManager.status_directory[effect].call(self)


func defend(shield:int)->void:
	defense += shield

func get_damage_multiplier(type:String) -> float:
	if type in resistances.keys():
		return resistances[type]/100.0
	else:
		return 1.0

func take_damage(incoming_damage:Damage, direct:bool = false)->void:
	var multiplier: float = get_damage_multiplier(incoming_damage.type)
	#print("multiplier for damage is: ",multiplier)
	var damage = roundi(incoming_damage.damage * multiplier)
	#print("my damage taken is ",damage, " of the type: ",incoming_damage.type)
	var current_damage:int=0
	if not direct:
		if damage < defense:
			defense -= damage
			return
		current_damage = damage - defense
		defense = 0
	else:
		current_damage = damage
	if current_damage >= health:
		health = 0
		return
	health -= current_damage
	print("ouch!", health )

func heal(heal_amount:int)->void:
	if health + heal_amount > max_health:
		health = max_health
	else:
		health += heal_amount

func export() -> Dictionary:
	return {"health":health}
