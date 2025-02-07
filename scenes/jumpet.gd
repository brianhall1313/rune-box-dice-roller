extends Monster

@onready var hit_position: Marker2D = $hit_position

@export var resistances:Dictionary = {
}
@export var attack:int = 10
@export var monster_name:String = "Jumpet"
@export var portrait:Image

var current_action_index:int


var actions:Array[Dictionary] = [
	{#be agressive, be be agressive
		"name":"Viscous Claw",
		"attack":func ():return do_damage(attack+10,"physical"),
		"damage_animation":"slash",
		"animation":"attack",
		"intent":"attack",
	},
	{#attack and defend
		"name":"Evasive Strike",
		"attack":func ():return do_damage(attack,"physical"),
		"defence":10, #armor
		"damage_animation":"slash",
		"animation":"attack",
		"intent":"special",
	},
	{#poison the player and do a tiny amount of damage
		"name":"Dirty Claw",
		"attack":func (): return do_damage(3,"physical"),#is a function cause callables are necessary for the current build
		"effect":{"poison":5},
		"damage_animation":"slash",
		"animation":"attack",
		"intent":"special",
	}
]

func add_effect(effect:PackedScene) -> void:
	var ani = effect.instantiate()
	hit_position.add_child(ani)
	ani.global_position = hit_position.global_position
	ani.restart()

func _ready() -> void:
	health.setup(health.max_health,health.max_health)
	ui.setup()
	sprite.play("idle")
	

func get_action() -> Dictionary:
	return actions[current_action_index]

func plan_turn() -> void:
	select_action()

func take_turn() -> void:
	pass

func select_action()-> void:
	current_action_index = randi_range(0,len(actions)-1)
	ui.intention(actions[current_action_index]["intent"])

func selected()->void:
	if sprite.material == Global.outline:
		sprite.material = null
		return
	sprite.material = Global.outline
	sprite.material.set_shader_parameter("width",1)
	sprite.material.set_shader_parameter("outline_color",Color("RED"))
	sprite.material.set_shader_parameter("minimal_flickering_alpha",.9)

func _on_click_box_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("click"):
		#print("interact")
		GlobalSignalBus.emit_enemy_interaction(self)
		
