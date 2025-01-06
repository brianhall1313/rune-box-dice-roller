extends Node2D

@onready var continue_button: Button = $UI/menu/continue

func _ready() -> void:
	if !SaveAndLoad.load_game():
		continue_button.disabled = true


func _on_new_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/player_creation.tscn")


func _on_continue_button_up() -> void:
	PlayerManager.load_player()
	get_tree().change_scene_to_file("res://scenes/overworld.tscn")


func _on_quit_button_up() -> void:
	get_tree().quit()
