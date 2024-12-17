extends Node

var player_name:String = "Default"
var max_health:int = 100
var health:int = max_health
var experience:int = 0
var stories:int = 0


var custom_options:Dictionary ={
	"Body":0,
	"Outfit":0,
	"Ears":0,
	"Hat":0
}

func set_player_to_default() -> void:
	max_health = 100
	health = max_health
	experience = 0
	stories = 0

func load_player() -> void:
	pass

func save_player() -> void:
	pass

func export() -> Dictionary:
	return {"health":health,"max_health":max_health}

func import(info:Dictionary) -> void:
	health = info["health"]

func reward(rewards) -> void:
	if rewards.has("stories"):
		stories += rewards["stories"]
	if rewards.has("exp"):
		experience += rewards["exp"]

func create_player(info:Dictionary) -> void:
	player_name = info["name"]
	custom_options = info["portrait"].duplicate()
	set_player_to_default()
