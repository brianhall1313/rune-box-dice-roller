extends Node

var status_directory:Dictionary={
	"poison":func (target):poison(target)
}

func poison(target) -> void:
	var poison_damage:Damage = Damage.new(target.status["poison"],"poison")
	print("takes poison damage ",poison_damage.damage)
	target.take_damage(poison_damage,true)
	target.status["poison"] -= 1
	if target.status["poison"] == 0:
		target.status.erase("poison")
