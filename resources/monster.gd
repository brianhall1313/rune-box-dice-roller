extends Node2D

class_name Monster

@export var health:Health
@export var sprite:AnimatedSprite2D
@export var status:Dictionary = {}
@export var ui:Monster_UI


func play_animation(animation_name:String)->void:
	if sprite.sprite_frames.get_animation_names().has(animation_name):
		print("playing damage animation~~~~~~~~~")
		sprite.play(animation_name)
		await sprite.animation_looped
		print("~~~~~~~~~~~~~~~~Done with animation")
		goto_idle()

func do_damage(attack_val:int, type:String) -> Damage:
	return Damage.new(attack_val,type)

func take_damage(initial_damage:Damage, direct:bool = false)->void:
	var initial_hp = health.health
	health.take_damage(initial_damage,direct)
	if initial_hp != health.health:
		var d = Damage.new(initial_hp - health.health,initial_damage.type)
		GlobalSignalBus.emit_display_damage(d,global_position)
		if health.health <= 0:
			death()
			GlobalSignalBus.emit_enemy_death(self)
		else:
			damage_effet()
	else:
		var d = Damage.new(0,initial_damage.type)
		GlobalSignalBus.emit_display_damage(d,global_position)
	ui.update()

func defend(defend_amount:int) -> void:
	health.defend(defend_amount)

func heal(heal_amount:int) -> void:
	health.heal(heal_amount)

func is_alive() -> bool:
	return health.health > 0

func start_turn() -> void:
	countdown_status()
	select_action()

func select_action()->void:
	pass#overwrite on individual monsters

func countdown_status() -> void:
	#print("status")
	for effect in status.keys():
		if StatusManager.countdown.keys().has(effect):
			StatusManager.countdown[effect].call(self)
			if StatusManager.effects_list.keys().has(effect):
				GlobalSignalBus.emit_add_effect(StatusManager.effects_list[effect],self)

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
	
func reset_defense() -> void:
	health.reset_defense()

func goto_idle():
	sprite.play("idle")

func death() -> void:
	#overwrite
	if sprite.sprite_frames.get_animation_names().has("death"):
		sprite.play("death")
		await sprite.animation_looped
		sprite.play("dead")
		await get_tree().create_timer(1.0).timeout
		var tween = create_tween()
		tween.tween_property(sprite,"modulate",Color("WHITE",0),1)
		await tween.finished
		queue_free()
	else:
		sprite.stop()
		await get_tree().create_timer(1.0).timeout
		var tween = create_tween()
		tween.tween_property(sprite,"modulate",Color("WHITE",0),1)
		await tween.finished
		queue_free()
