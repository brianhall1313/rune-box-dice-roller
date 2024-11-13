extends Control


@onready var dice_grid: GridContainer = $dice_grid_margin/dice_grid
@onready var die:PackedScene = preload("res://scenes/die.tscn")

var box_inventory:Array = []
var box_area:int=12

func _ready() -> void:
	update_grid()


func update_grid() -> void:
	box_inventory = InventoryManager.inventory.duplicate(true)
	box_inventory.shuffle()
	for item in box_inventory:
		if dice_grid.get_child_count()<12:
			var new = die.instantiate()
			dice_grid.add_child(new)
			new.setup(item["name"],item["type"],item["faces"])
			new.roll()
	while dice_grid.get_child_count() < 12:
		var new = die.instantiate()
		dice_grid.add_child(new)
		new.set_blank()
			
