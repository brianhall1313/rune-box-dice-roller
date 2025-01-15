extends Monster

@onready var selected_box: Panel = $selected_box
@onready var hit_position: Marker2D = $hit_position

@export var resistances:Dictionary = {
}
@export var attack:int = 10
@export var monster_name:String = "Wretched Stalker"
@export var portrait:Image

var current_action_index:int

enum {BASE, REGEN, CLAW}

var final_form:bool=false

var creature_state = BASE


var actions:Array[Dictionary] = [
	{#be agressive, be be agressive
		"name":"Bash",
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
var regen_actions:Array[Dictionary] = [
	{#be agressive, be be agressive
		"name":"Bash",
		"attack":func ():return do_damage(attack+10,"physical"),
		"animation":"regen_attack",
		"damage_animation":"slash",
	},
	{#attack and defend
		"name":"Reach Advantage",
		"defence":20,#armor
		"attack":func ():return do_damage(attack-5,"physical"),
		"animation":"regen_attack",
		"damage_animation":"slash",
	},
	{#poison the player and do a tiny amount of damage
		"name":"Soul Feast",
		"attack":func():return do_damage(attack,"physical"),
		"effect":{"disabled dice":5},
		"animation":"regen_attack",
		"damage_animation":"bite",
	}
]

var claw_actions:Array[Dictionary] = [
	{#be agressive, be be agressive
		"name":"Bash",
		"attack":func ():return do_damage(attack+10,"physical"),
		"animation":"regen_attack",
		"damage_animation":"slash",
	},
	{#attack and defend
		"name":"Reach Advantage",
		"defence":20,#armor
		"attack":func ():return do_damage(attack-5,"physical"),
		"animation":"regen_attack",
		"damage_animation":"slash",
	},
	{#poison the player and do a tiny amount of damage
		"name":"Soul Feast",
		"attack":func():return do_damage(attack,"physical"),
		"effect":{"disabled dice":5},
		"animation":"regen_attack",
		"damage_animation":"bite",
	},
	{
		"name":"Claw  Grasp",
		"attack":func():return do_damage(attack+5,"physical"),
		"effect":{"bleed":5},
		"animation":"claw_attack",
		"damage_animation":"slash",
	},
	
]

func _ready() -> void:
	health.setup(health.max_health,health.max_health)
	sprite.play("idle")

func plan_turn() -> void:
	select_action()

func take_turn() -> void:
	pass

func select_action()-> void:
	if creature_state == CLAW:
		current_action_index = randi_range(0,len(claw_actions)-1)
		return
	if creature_state == REGEN:
		current_action_index = randi_range(0,len(regen_actions)-1)
		return
	current_action_index = randi_range(0,len(actions)-1)


func get_action() -> Dictionary:
	if creature_state == CLAW:
		return claw_actions[current_action_index]
	if creature_state == REGEN:
		return regen_actions[current_action_index]
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

func damage_effet() -> void:
	if sprite.sprite_frames.get_animation_names().has("hit"):
		sprite.play("hit")
	var tween = create_tween()
	var init_pos:Vector2 = sprite.position
	var offset:int = 15
	tween.tween_property(sprite,"position",Vector2(init_pos.x,init_pos.y-offset),.1)
	tween.tween_property(sprite,"position",Vector2(init_pos.x,init_pos.y+offset),.1)
	tween.tween_property(sprite,"position",Vector2(init_pos.x,init_pos.y-offset),.1)
	tween.tween_property(sprite,"position",Vector2(init_pos.x,init_pos.y+offset),.1)
	tween.tween_property(sprite,"position",Vector2(init_pos.x,init_pos.y-offset),.1)
	tween.tween_property(sprite,"position",Vector2(init_pos.x,init_pos.y+offset),.1)
	tween.tween_property(sprite,"position",init_pos,.1)
	await tween.finished
	goto_idle()

func play_animation(animation_name:String)->void:
	if sprite.sprite_frames.get_animation_names().has(animation_name):
		print("playing damage animation~~~~~~~~~")
		sprite.play(animation_name)
		await sprite.animation_looped
		print("~~~~~~~~~~~~~~~~Done with animation")
		goto_idle()

func goto_idle() -> void:
	if creature_state == CLAW:
			sprite.play("claw_idle")
			return
	if creature_state == REGEN:
		sprite.play("regen_idle")
		return
	sprite.play("idle")


func _on_health_taken_damage() -> void:
	if health.health <= roundi(health.max_health/2) and !final_form:
		final_form = true
		if randi_range(0,1) == 0:
			creature_state = REGEN
			StatusManager.increase_effect(self,"Stalker Vigor",5)
		else:
			creature_state = CLAW
