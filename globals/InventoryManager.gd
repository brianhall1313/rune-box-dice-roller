extends Node

var default_inventory: Array[Dictionary] = [
		{#1
			"name":"Elemental",
			"type":"nature",
			"faces":["fire","water","earth","sky","life",""]
		},
		{#2
			"name":"Elemental",
			"type":"nature",
			"faces":["fire","water","earth","sky","life",""]
		},
		{#3
			"name":"Elemental",
			"type":"nature",
			"faces":["fire","water","earth","sky","life",""]
		},
		{#4
			"name":"Elemental",
			"type":"nature",
			"faces":["fire","water","earth","sky","life",""]
		},
		{#5
			"name":"Elemental",
			"type":"nature",
			"faces":["fire","water","earth","sky","life",""]

		},
		{#6
			"name":"Elemental",
			"type":"nature",
			"faces":["fire","water","earth","sky","life",""]

		},
		{#7
			"name":"Elemental",
			"type":"nature",
			"faces":["fire","water","earth","sky","life",""]

		},
		{#8
			"name":"Elemental",
			"type":"nature",
			"faces":["fire","water","earth","sky","life",""]
		},
		{#9
			"name":"Physical",
			"type":"craft",
			"faces":["temper","temper","lob","lob","",""]
		},
		{#10
			"name":"Physical",
			"type":"craft",
			"faces":["temper","temper","lob","lob","",""]
		},
		{#11
			"name":"Magical",
			"type":"arcane",
			"faces":["echo","echo","reflect","reflect","",""]
		},
		{#12
			"name":"Magical",
			"type":"arcane",
			"faces":["echo","echo","reflect","reflect","",""]
		},
		{#13
			"name":"Magical",
			"type":"arcane",
			"faces":["","","","","",""]
		}
	]

var inventory: Array[Dictionary] = []

func _ready() -> void:
	build_inventory()

func build_inventory(new_inv:Array=default_inventory)->void:
	inventory = new_inv.duplicate(true)


func remove_item(remove_item)->void:
	#TODO
	pass

func add_item(new_item)->void:
	#TODO
	pass
