extends Monster

@onready var selected_box: Panel = $selected_box
@onready var hit_position: Marker2D = $hit_position

@export var resistances:Dictionary = {
}
@export var attack:int = 10
@export var monster_name:String = "Wretched Stalker"
@export var portrait:Image

var current_action_index:int



var actions:Array[Dictionary] = [
	{#be agressive, be be agressive
		"name":"Swipe",
		"attack":func ():return do_damage(attack+10,"physical"),
		"animation":"attack",
		"damage_animation":"slash",
	},
	{#attack and defend
		"name":"Reach Advantage",
		"defence":20,#armor
		"attack":func ():return do_damage(attack-5,"physical"),
		"animation":"attack",
		"damage_animation":"slash",
	},
	{#poison the player and do a tiny amount of damage
		"name":"Soul Feast",
		"attack":func():return do_damage(attack,"physical"),
		"effect":{"disabled dice":5},
		"animation":"attack",
		"damage_animation":"bite",
	}
]


func _ready() -> void:
	health.setup(health.max_health,health.max_health)
	sprite.play("idle")

func plan_turn() -> void:
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
		
