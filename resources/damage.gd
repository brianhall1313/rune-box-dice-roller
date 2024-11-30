extends Node
class_name Damage

@export var damage: int = 0
@export var type: String = 'null'

func _init(new_damage:int, new_type:String)->void:
	self.damage = new_damage
	self.type = new_type
