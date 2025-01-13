extends Node2D

@onready var player_info: Label = $ui/main_ui/player_info



func _ready() -> void:
	connect_to_gobalsignalbus()
	player_info.text = ("player " + PlayerManager.player_name +  
	"  player health: " + str(PlayerManager.health) + "/" + str(PlayerManager.max_health) + 
	"  stories: " + str(PlayerManager.stories) + 
	"  exp: " + str(PlayerManager.experience)
	)


func connect_to_gobalsignalbus() -> void:
	GlobalSignalBus.connect("level_selected",level_selector)


func level_selector(level_ID:int) -> void:
	if level_ID < len(EncounterDirectory.encounters):
		Global.next_level = level_ID
		get_tree().change_scene_to_file("res://scenes/encounter.tscn")


func _on_quit_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
