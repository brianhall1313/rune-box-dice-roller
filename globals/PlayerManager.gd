extends Node

var player_name:String = "Default"
var max_health:int = 100
var health:int = max_health
var shifts:int = 0

func load_player()->void:
	pass

func save_player()->void:
	pass

func export() -> Dictionary:
	return {"health":health,"max_health":max_health}
