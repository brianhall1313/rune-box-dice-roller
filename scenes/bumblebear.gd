extends AnimatedSprite2D


@export var max_health:int = 100
@export var health:int = 100
@export var attack:int = 10
@export var defence:int = 0

var current_action_index:int

var actions:Array[Dictionary] = [
	{#be agressive, be be agressive
		"name":"Proboscis",
		"attack":func ():return attack+25,
		"animation":"attack",
	},
	{#attack and defend
		"name":"Evasive Strike",
		"defence":40, #armor
		"animation":"none",
	},
	{#poison the player and do a tiny amount of damage
		"name":"Hooked Claws",
		"attack":func():return attack,
		"effect":{"bleed":5},
		"animation":"attack",
	}
]

func _ready() -> void:
	pass

func take_turn() -> void:
	defence = 0
	select_action()

func select_action()-> void:
	current_action_index = randi_range(0,len(actions)-1)

func play_animation(animation_name:String)->void:
	if sprite_frames.get_animation_names().has(animation_name):
		play_animation(animation_name)

func heal_damage(amount:int)->void:
	if amount + health > max_health:
		health = max_health
		return
	health += amount

func take_damage(damage:int)->void:
	if damage < defence:
		defence -= damage
		return
	var current_damage = damage - defence
	defence = 0
	if current_damage > health:
		health = 0
		return
	health -= current_damage
