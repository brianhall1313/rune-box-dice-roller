extends Control

@onready var inventory_container: GridContainer = $main/inventory/inventory_margin/inventory_display/inventory_scroll/inventory_container
@onready var dice_entry: PackedScene = preload("res://scenes/dice_entry.tscn")

func _ready() -> void:
	populate_inventory()

func populate_inventory() -> void:
	var display_inventory = []
	for item in InventoryManager.inventory:
		if !display_inventory.has(item):
			display_inventory.append(item.duplicate(true))
	for item in display_inventory:
		item["count"]=InventoryManager.inventory.count(item)
	#TODO the rest of this nonsense
	for item in display_inventory:
		var new = dice_entry.instantiate()
		inventory_container.add_child(new)
		new.setup(item)


func _on_exit_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/overworld.tscn")
