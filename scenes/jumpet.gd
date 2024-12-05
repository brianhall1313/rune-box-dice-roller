extends AnimatedSprite2D
class_name Monster

@onready var selected_box: Panel = $selected_box

@export var resistances:Dictionary = {
	"fire":150,
}
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
		"attack":func ():return do_damage(attack+10,"physical"),
		"animation":"attack",
	},
	{#attack and defend
		"name":"Evasive Strike",
		"attack":func ():return do_damage(attack,"physical"),
		"defence":10, #armor
		"animation":"attack",
	},
	{#poison the player and do a tiny amount of damage
		"name":"Dirty Claw",
		"attack":func (): return do_damage(3,"physical"),#is a function cause callables are necessary for the current build
		"effect":{"poison":5},
		"animation":"attack",
	}
]


func _ready() -> void:
	pass

func plan_turn() -> void:
	defence = 0
	select_action()

func take_turn() -> void:
	pass

func select_action()-> void:
	current_action_index = randi_range(0,len(actions)-1)

func play_animation(animation_name:String)->void:
	if sprite_frames.get_animation_names().has(animation_name):
		play_animation(animation_name)

func do_damage(attack_val:int, type:String) -> Damage:
	return Global.damage.new(attack_val,type)
	

func heal_damage(amount:int)->void:
	if amount + health > max_health:
		health = max_health
		return
	health += amount

func get_damage_multiplier(type:String) -> float:
	if resistances.keys().has(type):
		return resistances[type]/100.0
	else:
		return 1.0

func take_damage(initial_damage:Damage)->void:
	var multiplier: float = get_damage_multiplier(initial_damage.type)
	#print("multiplier for damage is: ",multiplier)
	var damage = roundi(initial_damage.damage * multiplier)
	#print("my damage taken is ",damage, " of the type: ",initial_damage.type)
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
		
