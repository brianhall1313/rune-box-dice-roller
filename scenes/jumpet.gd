extends AnimatedSprite2D
class_name Monster

@onready var selected_box: Panel = $selected_box

@export var max_health:int = 20
@export var health:int = max_health
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

func plan_turn() -> void:
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
	defence = 0 # you will inevitably lose all you defence if you are this far
	if current_damage >= health:
		health = 0
		print("OWIE!!! jumpet died")
		GlobalSignalBus.emit_enemy_death(self)
		return
	health -= current_damage

func selected()->void:
	selected_box.visible = !selected_box.visible

func _on_click_box_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("click"):
		GlobalSignalBus.emit_enemy_interaction(self)
		
