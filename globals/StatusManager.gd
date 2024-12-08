extends Node

var status_directory:Dictionary={
	"poison":func (target):poison(target),
	"regen":func (target):regen(target),
}


func reduce_effect(target,effect_name:String,amount:int) -> void:
	target.status[effect_name] -= amount
	if target.status[effect_name] <= 0:
		target.status.erase(effect_name)

func increase_effect(target,effect_name:String,amount:int) -> void:
	if target.status.keys().has(effect_name):
		target.status[effect_name] += amount
		return
	target.status[effect_name] = amount

func poison(target) -> void:
	var poison_damage:Damage = Damage.new(target.status["poison"],"poison")
	print("takes poison damage ",poison_damage.damage)
	target.take_damage(poison_damage,true)
	target.status["poison"] -= 1
	if target.status["poison"] == 0:
		target.status.erase("poison")

func regen(target) -> void:
	var regen_amount:int = target.status["regen"]
	target.heal(regen_amount)
	target.status["regen"] -= 1
	if target.status["regen"] == 0:
		target.status.erase("regen")
