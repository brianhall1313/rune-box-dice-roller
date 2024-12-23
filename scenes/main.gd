extends Node2D

func _ready() -> void:
	pass


func _on_new_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/player_creation.tscn")


func _on_continue_button_up() -> void:
	PlayerManager.load_player()
	get_tree().change_scene_to_file("res://scenes/liminal.tscn")


func _on_quit_button_up() -> void:
	get_tree().quit()
