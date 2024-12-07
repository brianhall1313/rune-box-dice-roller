extends Node2D

class_name Monster

@export var health:Health
@export var sprite:AnimatedSprite2D
@export var status:Dictionary = {}


func play_animation(animation_name:String)->void:
	if sprite.sprite_frames.get_animation_names().has(animation_name):
		play_animation(animation_name)

func do_damage(attack_val:int, type:String) -> Damage:
	return Global.damage.new(attack_val,type)

func take_damage(initial_damage:Damage, direct:bool = false)->void:
	health.take_damage(initial_damage,direct)
	if health.health == 0:
		GlobalSignalBus.emit_enemy_death(self)

func defend(defend_amount:int) -> void:
	health.defend(defend_amount)


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
