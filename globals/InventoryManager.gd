extends Node

var default_inventory: Array[Dictionary] = [
		{#1
			"type":"nature",
			"sides":["fire","water","earth","sky","life",""]
		},
		{#2
			"type":"nature",
			"sides":["fire","water","earth","sky","life",""]
		},
		{#3
			"type":"nature",
			"sides":["fire","water","earth","sky","life",""]
		},
		{#4
			"type":"nature",
			"sides":["fire","water","earth","sky","life",""]
		},
		{#5
			"type":"nature",
			"sides":["fire","water","earth","sky","life",""]

		},
		{#6
			"type":"nature",
			"sides":["fire","water","earth","sky","life",""]

		},
		{#7
			"type":"nature",
			"sides":["fire","water","earth","sky","life",""]

		},
		{#8
			"type":"nature",
			"sides":["fire","water","earth","sky","life",""]
		},
		{#9
			"type":"craft",
			"sides":["temper","temper","lob","lob","",""]
		},
		{#10
			"type":"craft",
			"sides":["temper","temper","lob","lob","",""]
		},
		{#11
			"type":"arcane",
			"sides":["temper","temper","lob","lob","",""]
		},
		{#12
			"type":"arcane",
			"sides":["temper","temper","lob","lob","",""]
		},
		{#13
			"type":"arcane",
			"sides":["","","","","",""]
		}
	]

var inventory: Array[Object] = []

func build_inventory(new_inv:Array=default_inventory)->void:
	inventory = new_inv.duplicate(true)

func remove_item(remove_item)->void:
	#TODO
	pass

func add_item(new_item)->void:
	#TODO
	pass
