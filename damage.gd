extends Node
class_name Damage

@export var damage: int = 0
@export var type: String = 'null'

func setup(new_damage:int, new_type:String)->void:
	damage = new_damage
	type = new_type
