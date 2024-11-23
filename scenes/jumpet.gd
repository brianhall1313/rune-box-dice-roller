extends AnimatedSprite2D
class_name Monster

@export var max_health:int = 100
@export var health:int = 100
@export var attack:int = 10
@export var defence:int = 0
@export var monster_name:String = "Jumpet"
@export var portrait:Image

var current_action_index:int

var status_effects:Array[Dictionary]=[]

var actions:Array[Dictionary] = [
	{#be agressive, be be agressive
		"name":"Viscous Claw",
		"attack":func ():return attack+10,
		"animation":"attack",
	},
	{#attack and defend
		"name":"Evasive Strike",
		"attack":func ():return attack,
		"defence":10, #armor
		"animation":"attack",
	},
	{#poison the player and do a tiny amount of damage
		"name":"Dirty Claw",
		"attack":3,
		"effect":{"poison":5},
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


func _on_click_box_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_released("click"):
		GlobalSignalBus.enemy_interaction.emit(self)
