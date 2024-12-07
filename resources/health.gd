extends Node
class_name Health


@export var max_health:int = 100
@export var health:int = max_health
@export var defense:int = 0
@export var resistances:Dictionary = {}


#this is probably only for the player character, but it needs to be here
func setup(new_max_health:int,new_health:int) -> void:
	self.max_health = new_max_health
	self.health = new_health

func defend(shield:int)->void:
	defense += shield

func reset_defense() -> void:
	defense = 0

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
	print(damage, " damage vs ", defense)
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
	print(get_parent().name," says ouch! I got hit for ", damage, " and took ", current_damage )

func heal(heal_amount:int)->void:
	if health + heal_amount > max_health:
		health = max_health
	else:
		health += heal_amount
