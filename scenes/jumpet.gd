extends AnimatedSprite2D


@export var max_health:int = 100
@export var health:int = 100
@export var attack:int = 10
@export var defence:int = 0

var current_action_index:int

var actions:Array[Dictionary] = [
	{#be agressive, be be agressive
		"name":"Viscous Claw",
		"attack":func ():return attack+10,
	},
	{#attack and defend
		"name":"Evasive Strike",
		"attack":func ():return attack,
		"defence":func ():return 10 #armor
	},
	{#poison the player
		"name":"Dirty Claw",
		"attack":func ():return 3,
		"effect":func ():return {"poison":5}
	}
]

func _ready() -> void:
	pass

func take_turn() -> void:
	select_action()

func select_action()-> void:
	current_action_index = randi_range(0,len(actions))

func play_animation(animation_name:String)->void:
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
