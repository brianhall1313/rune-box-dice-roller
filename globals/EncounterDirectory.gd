extends Node

var encounters: Array[Dictionary] = [
	{
		"encounter_name":"",
		"encounter_number":0,
		"enemies":[
			{
				"enemy":"jumpet",
				"name":"Jumpet",
				"position":Vector2(8, 35)
			}
		]
	},
	{
		"encounter_name":"",
		"encounter_number":1,
		"enemies":[
			{
				"enemy":"bumblebear",
				"name":"Bumblebear",
				"position":Vector2(-1, 33)
			}
		]
	},
	{
		"encounter_name":"",
		"encounter_number":2,
		"enemies":[
			{
				"enemy":"wretched_stalker",
				"name":"Wretched Stalker",
				"position":Vector2(7, 38)
			}
		]
	},
	{
		"encounter_name":"",
		"encounter_number":3,
		"enemies":[
			{
				"enemy":"war_jumpet",
				"name":"War Jumpet",
				"position":Vector2(7, 14)
			}
		]
	},
	{
		"encounter_name":"",
		"encounter_number":4,
		"enemies":[
			{
				"enemy":"jumpet",
				"name":"George",
				"position":Vector2(-59, 35)
			},
			{
				"enemy":"jumpet",
				"name":"Paul",
				"position":Vector2(70, 35)
			},
		]
	},
]

var monster_directory: Dictionary = {
	"jumpet":preload("res://scenes/jumpet.tscn"),
	"bumblebear":preload("res://scenes/bumblebear.tscn"),
	"wretched_stalker":preload("res://scenes/wretched_stalker.tscn"),
	"war_jumpet":preload("res://scenes/war_jumpet.tscn")
}
