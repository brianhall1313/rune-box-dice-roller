extends Control


@onready var dice_grid: GridContainer = $dice_grid_margin/dice_grid
@onready var die:PackedScene = preload("res://scenes/die.tscn")

var box_inventory:Array = []
var box_area:int=12

var dice_grid_array:Array = []


func _ready() -> void:
	update_grid()
	build_dice_grid_array()


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

func build_dice_grid_array()->void:
	var column_count = dice_grid.columns
	var dice = dice_grid.get_children()
	#reset the array
	dice_grid_array = []
	var i = 0
	for row in len(dice)/column_count:
		dice_grid_array.append([])
		for column in column_count:
			dice_grid_array[row].append(dice[i])
			i += 1
