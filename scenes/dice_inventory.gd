extends ScrollContainer


@onready var dice_list: VBoxContainer = $dice_list
@onready var dice_entry:PackedScene=preload("res://scenes/dice_entry.tscn")

var display_inventory:Array
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_display()


func update_display() -> void:
	display_inventory = []
	for item in InventoryManager.inventory:
		if !display_inventory.has(item):
			display_inventory.append(item.duplicate(true))
	for item in display_inventory:
		item["count"]=InventoryManager.inventory.count(item)
	#TODO the rest of this nonsense
	for item in display_inventory:
		var new = dice_entry.instantiate()
		dice_list.add_child(new)
		new.setup(item)
		
