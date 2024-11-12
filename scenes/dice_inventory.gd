extends ScrollContainer

var display_inventory:Array
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display_inventory = []
	display_inventory.append(InventoryManager.inventory[0].duplicate(true))
	display_inventory[len(display_inventory)-1]["count"] = 1
	for i in InventoryManager.inventory:
		for x in display_inventory:
			if display_inventory.has(i):
				display_inventory[display_inventory.find(i)]["count"] += 1
			else:
				display_inventory.append(i.duplicate(true))
				display_inventory[len(display_inventory)-1]["count"] = 1
