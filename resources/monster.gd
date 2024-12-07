extends Node2D

class_name Monster

@export var health:Health
@export var sprite:AnimatedSprite2D


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
