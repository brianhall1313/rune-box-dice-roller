extends Node

var player_name:String = "Default"
var player_max_health:int = 100
var player_current_health:int = player_max_health
var shifts:int = 0

func load_player()->void:
	pass

func save_player()->void:
	pass

func take_damage(damage:int)->void:
	if damage >= player_current_health:
		player_current_health = 0
		GlobalSignalBus.player_death.emit()
	else:
		player_current_health -= damage

func heal(heal_amount:int)->void:
	if player_current_health + heal_amount > player_max_health:
		player_current_health = player_max_health
	else:
		player_current_health += heal_amount
