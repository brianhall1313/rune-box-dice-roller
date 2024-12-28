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
	"Hat":0,
	"Eyes":0
}

func set_player_to_default() -> void:
	max_health = 100
	health = max_health
	experience = 0
	stories = 0
	InventoryManager.build_inventory()#no args = set to default inv

func load_player() -> void:
	var data:Dictionary = SaveAndLoad.load_game()
	if data.keys().has("inventory"):
		InventoryManager.build_inventory(data["inventory"])
	else:
		print("inventory not found! loading default")
		InventoryManager.build_inventory()
	if data.keys().has("custom_options"):
		custom_options = data["custom_options"].duplicate()
	else:
		print("custom_options not found! loading default")
	if data.keys().has("player_name"):
		player_name = data["player_name"]
	else:
		print("player_name not found! loading default")
	if data.keys().has("max_health"):
		max_health = data["max_health"]
	else:
		print("max_health not found! loading default")
	if data.keys().has("health"):
		health = data["health"]
	else:
		print("health not found! loading default")
	if data.keys().has("experience"):
		experience = data["experience"]
	else:
		print("experience not found! loading default")
	if data.keys().has("stories"):
		stories = data["stories"]
	else:
		print("stories not found! loading default")
	print("PLAYER LOADED")
	
	

func save_player() -> void:
	SaveAndLoad.save_game({
		"inventory":InventoryManager.inventory.duplicate(),
		"custom_options":custom_options.duplicate(),
		"player_name":player_name,
		"max_health":max_health,
		"health":health,
		"experience":experience,
		"stories":stories
	})
	print("PLAYER SAVED")

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
