extends Node

var player_name:String = "Default"
var max_health:int = 100
var health:int = max_health
var experience:int = 0
var stories:int = 0
var exp:int = 0
func load_player()->void:
	pass

func save_player()->void:
	pass

func export() -> Dictionary:
	return {"health":health,"max_health":max_health}

func import(info:Dictionary) -> void:
	health = info["health"]
func reward(rewards) -> void:
	if rewards.has("stories"):
		stories += rewards["stories"]
	if rewards.has("exp"):
		exp += rewards["exp"]
