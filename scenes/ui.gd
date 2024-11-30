extends Control

@onready var player_info_element: Control = $player_info_element
@onready var right_panel: Control = $right_panel
@onready var active_panel: Control = $active_panel

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
