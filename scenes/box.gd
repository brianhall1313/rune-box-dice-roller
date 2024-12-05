extends Control


@onready var dice_grid: GridContainer = $dice_grid_margin/dice_grid
@onready var die:PackedScene = preload("res://scenes/die.tscn")

var box_inventory:Array = []
var box_area:int=12

var dice_grid_array:Array = []


func _ready() -> void:
	update_grid()
	build_dice_grid_array()
	set_adjacency()


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
	@warning_ignore("integer_division")
	#
	for row in roundi(len(dice)/column_count):
		dice_grid_array.append([])
		for column in column_count:
			dice_grid_array[row].append(dice[i])
			dice[i].set_pos({"x":row,"y":column})
			i += 1

func set_adjacency()->void:
	var dice = dice_grid.get_children()
	var column_count = dice_grid.columns
	var row_count = len(dice_grid_array)
	for d:Die in dice:
		var adjacent:Dictionary = {"up":"up","down":"down","right":"right","left":"left",}
		#I always get cols and rows mixed up in 2d arrays
		#right
		if d.pos["y"]-1 >= 0:
			adjacent["right"] = dice_grid_array[d.pos["x"]][d.pos["y"]-1]
		#left
		if d.pos["y"]+1 < column_count:
			adjacent["left"] = dice_grid_array[d.pos["x"]][d.pos["y"]+1]
		#up
		if d.pos["x"]-1 >= 0:
			adjacent["up"] = dice_grid_array[d.pos["x"]-1][d.pos["y"]]
		#down
		if d.pos["x"]+1 < row_count:
			adjacent["down"] = dice_grid_array[d.pos["x"]+1][d.pos["y"]]
		d.set_adjacent(adjacent)

func shake_box()->void:
	print("poke")
	box_inventory = InventoryManager.inventory.duplicate(true)
	box_inventory.shuffle()
	var i:int = 0
	var dice = dice_grid.get_children()
	for item in box_inventory:
		if i < 12:
			dice[i].setup(item["name"],item["type"],item["faces"])
			dice[i].roll()
			dice[i].set_selected(false)
		i += 1
	while i < 12:
		dice[i].set_blank()
		i += 1
