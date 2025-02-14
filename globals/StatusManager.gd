extends Node

#debuffs/negative staus conditions
const BLEED:String = "bleed"
const BLIGHT:String = "blight"
const POISON:String = "poison"

#buffs
const DEF_UP:String = "def up"
const REGEN:String = "regen"
const SV:String = "Stalker Vigor"

@onready var condition_icons: Dictionary = {
	BLEED:preload("res://textures/Buttons-Menus/Bleed.png"),
	BLIGHT:preload("res://textures/Buttons-Menus/Blight.png"),
	DEF_UP:preload("res://textures/Buttons-Menus/Def up.png"),
	POISON:preload("res://textures/Buttons-Menus/Poisoned.png"),
	REGEN:preload("res://textures/Buttons-Menus/Regen.png"),
	SV:preload("res://textures/Buttons-Menus/Regen.png")
}

@onready var status_descriptions: Dictionary = {
	BLEED:{"title":"Bleed","description":"Deals Damage every time an action is taken."},
	BLIGHT:{"title":"Blight","description":"Take damage if Die is used."},
	DEF_UP:{"title":"Defense Up","description":"Adds more defense when a defend action is taken"},
	POISON:{"title":"Poison","description":"Deals Damage at the start of turn."},
	REGEN:{"title":"Regen","description":"Heals Damage at the starrt of turn."},
	SV:{"title":"Stalker Vigor","description":"Heals damage every turn."},
}

var effects_list:Dictionary={
	POISON:preload("res://resources/damage_animations/poison_damage_effect.tscn"),
}

var countdown:Dictionary = {
	POISON:func (target):poison(target),
	REGEN:func (target):regen(target),
	SV:func (target):sv(target),
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
	#print("takes poison damage ",poison_damage.damage)
	reduce_effect(target,POISON)
	target.take_damage(poison_damage,true)

func regen(target) -> void:
	var regen_amount:int = target.status[REGEN]
	reduce_effect(target,REGEN)
	target.heal(regen_amount)

func sv(target) -> void:
	var regen_amount:int = target.status[SV]
	target.heal(regen_amount)
	

func bleed(target) -> void:
	reduce_effect(target,BLEED)
	target.take_damage(Damage.new(1,BLEED),true)
