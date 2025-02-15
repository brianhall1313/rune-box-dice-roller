extends Control

@onready var inventory_container: GridContainer = $main/inventory/inventory_margin/inventory_display/inventory_scroll/inventory_container
@onready var dice_entry: PackedScene = preload("res://resources/inventory_dice_entry.tscn")
@onready var popup: PanelContainer = $popup
@onready var dni_panel: Panel = $"DNI panel"

var display_inventory:Array[Dictionary] = []


func _ready() -> void:
	populate_inventory()

func populate_inventory() -> void:
	display_inventory = []
	for item in InventoryManager.inventory:
		display_inventory.append(item.duplicate(true))
	var i:int = 0
	for item in display_inventory:
		var new = dice_entry.instantiate()
		inventory_container.add_child(new)
		new.setup(item,i)
		i += 1
	attach_signals()

func update_inventory() -> void:
	for child in inventory_container.get_children():
		child.disconnect("delete",_delete_item_at)
		child.queue_free()
	var i:int = 0
	for item in display_inventory:
		var new = dice_entry.instantiate()
		inventory_container.add_child(new)
		new.setup(item,i)
		i += 1
	attach_signals()

func attach_signals() -> void:
	for child in inventory_container.get_children():
		child.connect("delete",_delete_item_at)


func _on_exit_button_button_up() -> void:
	dni_panel.show()
	popup.show()

func _delete_item_at(index) -> void:
	display_inventory.remove_at(index)
	#print(display_inventory)
	update_inventory()
	


func _on_undo_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/overworld.tscn")


func _on_confirm_button_up() -> void:
	#update inventory state
	InventoryManager.build_inventory(display_inventory)
	#inventory and player state get saved together
	PlayerManager.save_player()
	#go to world map
	get_tree().change_scene_to_file("res://scenes/overworld.tscn")
	


func _on_go_back_button_up() -> void:
	dni_panel.hide()
	popup.hide()
