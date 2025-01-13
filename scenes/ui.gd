extends Control

@onready var player_info_element: Control = $player_info_element
@onready var right_panel: Control = $right_panel
@onready var active_panel: Control = $active_panel
@onready var player_point = player_info_element.effect_point
@onready var message_label: Label = $message_label

func update_player(player_information)->void:
	player_info_element.update(player_information)

func update_right_panel(spell_information) -> void:
	right_panel.update({"spell":spell_information})

func update_enemy_info(enemy:Monster)->void:
	right_panel.update({
		"enemy":enemy
	})

func toggle_shake(active:bool)->void:
	active_panel.toggle_shake(active)

func update_player_information(scene_player:player) -> void:
	player_info_element.update_player_information(scene_player)

func add_effect_to_player(effect:PackedScene) -> void:
	player_info_element.add_effect(effect)

func remove_effect_from_player() -> void:
	player_info_element.remove_effect()

func shake_box() -> void:
	active_panel.shake_box()

func player_took_damage(damage) -> void:
	player_info_element.player_damage_effect(damage)

func display_message(message:String) -> void:
	print(message)
	var tween = create_tween()
	message_label.modulate = Color("white",0.0)
	message_label.text = message
	tween.tween_property(message_label,"modulate",Color("white",1.0),.2)
	await get_tree().create_timer(1.0).timeout
	tween = create_tween()
	tween.tween_property(message_label,"modulate",Color("white",0.0),1)
	
	
	
	
