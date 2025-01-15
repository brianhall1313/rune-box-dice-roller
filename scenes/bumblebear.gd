extends Monster

@onready var selected_box: Panel = $selected_box
@onready var hit_position: Marker2D = $hit_position

@export var resistances:Dictionary = {
}
@export var attack:int = 10
@export var monster_name:String = "Bumblebear"
@export var portrait:Image

var current_action_index:int



var actions:Array[Dictionary] = [
	{#be agressive, be be agressive
		"name":"Proboscis",
		"attack":func ():return do_damage(attack+25,"physical"),
		"damage_animation":"bite",
		"animation":"attack"
	},
	{#attack and defend
		"name":"Curl up",
		"defence":40,
		"damage_animation":"slash",
		"animation":"attack"
	},
	{#poison the player and do a tiny amount of damage
		"name":"Hooked Claws",
		"attack":func():return do_damage(attack,"physical"),
		"effect":{"bleed":5},
		"damage_animation":"slash",
		"animation":"attack"
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

func get_action() -> Dictionary:
	return actions[current_action_index]

func selected()->void:
	selected_box.visible = !selected_box.visible

func _on_click_box_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("click"):
		GlobalSignalBus.emit_enemy_interaction(self)
		
func add_effect(effect:PackedScene) -> void:
	var ani = effect.instantiate()
	hit_position.add_child(ani)
	ani.global_position = hit_position.global_position
	ani.restart()
