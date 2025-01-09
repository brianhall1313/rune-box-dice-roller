extends Node

const BLEED:String = "bleed"
const POISON:String = "poison"
const REGEN:String = "regen"


var countdown:Dictionary = {
	POISON:func (target):poison(target),
	REGEN:func (target):regen(target),
}

var per_action: Dictionary= {
	BLEED:func (target):bleed(target)
}


func reduce_effect(target,effect_name:String,amount:int=1) -> void:
	target.status[effect_name] -= amount
	if target.status[effect_name] <= 0:
		target.status.erase(effect_name)

func increase_effect(target,effect_name:String,amount:int=1) -> void:
	if target.status.keys().has(effect_name):
		target.status[effect_name] += amount
		return
	target.status[effect_name] = amount

func poison(target) -> void:
	var poison_damage:Damage = Damage.new(target.status[POISON],POISON)
	print("takes poison damage ",poison_damage.damage)
	target.take_damage(poison_damage,true)
	reduce_effect(target,POISON)

func regen(target) -> void:
	var regen_amount:int = target.status[REGEN]
	target.heal(regen_amount)
	reduce_effect(target,REGEN)

func bleed(target) -> void:
	target.take_damage(1,true)
	target.status[BLEED] -= 1
	reduce_effect(target,BLEED)
