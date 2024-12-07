extends Monster

@onready var selected_box: Panel = $selected_box

@export var resistances:Dictionary = {
	"fire":150,
}
@export var attack:int = 10
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
	health.reset_defense()
	select_action()

func take_turn() -> void:
	pass

func select_action()-> void:
	current_action_index = randi_range(0,len(actions)-1)


func selected()->void:
	selected_box.visible = !selected_box.visible

func _on_click_box_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("click"):
		GlobalSignalBus.emit_enemy_interaction(self)
		
