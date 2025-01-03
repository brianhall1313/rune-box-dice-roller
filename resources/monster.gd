extends Node2D

class_name Monster

@export var health:Health
@export var sprite:AnimatedSprite2D
@export var status:Dictionary = {}

func play_animation(animation_name:String)->void:
	if sprite.sprite_frames.get_animation_names().has(animation_name):
		GlobalSignalBus.emit_state_change("animation_playing")
		print("playing damage animation~~~~~~~~~")
		sprite.play(animation_name)
		await sprite.animation_looped
		print("~~~~~~~~~~~~~~~~Done with animation")
		GlobalSignalBus.emit_action_finished()
		GlobalSignalBus.emit_revert_state()
		sprite.play("idle")

func do_damage(attack_val:int, type:String) -> Damage:
	return Damage.new(attack_val,type)

func take_damage(initial_damage:Damage, direct:bool = false)->void:
	damage_effet()
	health.take_damage(initial_damage,direct)
	if health.health == 0:
		GlobalSignalBus.emit_enemy_death(self)

func defend(defend_amount:int) -> void:
	health.defend(defend_amount)

func heal(heal_amount:int) -> void:
	health.heal(heal_amount)

func is_alive() -> bool:
	return health.health > 0

func start_turn() -> void:
	update_status()
	select_action()

func select_action()->void:
	pass#overwrite on individual monsters

func update_status() -> void:
	print("status")
	for effect in status.keys():
		if StatusManager.status_directory.keys().has(effect):
			StatusManager.status_directory[effect].call(self)

func add_effect(effect_name:String, effect_value:int) -> void:
	if status.keys().has(effect_name):
		status[effect_name] += effect_value
		return
	status[effect_name] = effect_value

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
	sprite.play("idle")
	
func reset_defense() -> void:
	health.reset_defense()
