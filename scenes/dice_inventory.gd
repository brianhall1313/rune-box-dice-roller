extends ScrollContainer

var display_inventory:Array
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("oop")
	display_inventory = []
	display_inventory.append({"die":InventoryManager.inventory[0].duplicate(true),"count":1})
	for i in InventoryManager.inventory:
		print(i)
		#broken
		for x in display_inventory:
			print(x)
			if x["die"] == i:
				x["count"] += 1
			else:
				display_inventory.append(i.duplicate(true))
