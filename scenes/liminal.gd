extends Node2D

@onready var player_info: Label = $Panel/VBoxContainer/player_info

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_info.text = ("player " + PlayerManager.player_name + "\n" + 
	"      player health: " + str(PlayerManager.health) + "/" + str(PlayerManager.max_health) + "\n" +
	"		stories: " + str(PlayerManager.stories) + "\n" + 
	"		exp: " + str(PlayerManager.exp)
	)


func _on_next_fight_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/encounter.tscn")


func _on_exit_button_up() -> void:
	get_tree().quit()
