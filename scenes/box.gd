extends Control

@onready var die_1: TextureRect = $dice_grid/GridContainer/die
@onready var die_2: TextureRect = $dice_grid/GridContainer/die2
@onready var die_3: TextureRect = $dice_grid/GridContainer/die3
@onready var die_4: TextureRect = $dice_grid/GridContainer/die4
@onready var die_5: TextureRect = $dice_grid/GridContainer/die5
@onready var die_6: TextureRect = $dice_grid/GridContainer/die6
@onready var die_7: TextureRect = $dice_grid/GridContainer/die7
@onready var die_8: TextureRect = $dice_grid/GridContainer/die8
@onready var die_9: TextureRect = $dice_grid/GridContainer/die9
@onready var die_10: TextureRect = $dice_grid/GridContainer/die10
@onready var die_11: TextureRect = $dice_grid/GridContainer/die11
@onready var die_12: TextureRect = $dice_grid/GridContainer/die12


@onready var grid:Array[Array] = [
		[
			die_1,
			die_2,
			die_3,
			die_4
		],
		[
			die_5,
			die_6,
			die_7,
			die_8
		],
		[
			die_9,
			die_10,
			die_11,
			die_12
		]
	]


func update_grid() -> void:
	var box_inventory = InventoryManager.inventory.duplicate(true)
	box_inventory.shuffle()
	var i = 0
	for x in len(grid):
		for y in len(grid[x]):
			grid[x][y].setup(box_inventory[i]["name"],box_inventory[i]["type"],box_inventory[i]["faces"])
			grid[x][y].roll()
			i += 1
			

func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_accept"):
		update_grid()
