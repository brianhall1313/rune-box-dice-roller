extends Control

@onready var player_portrait = $VBoxContainer/player_info/player_portrait
@onready var player_name = $VBoxContainer/player_info/player_name
# Called when the node enters the scene tree for the first time.

var dice_list = []
func _ready() -> void:
	# set this on load/new in some global state and use it here
	player_name.text = "Your Name"
	# portrait can be set too, but we don't have anything yet anyway
	# and set the dice list to a bunch of real stuff (loaded or initial)
	# dice_list = InventoryManager.inventory
	dice_list = [
		# these will be die objects, but for now just data hash describing it
		{"name": "elemental", "type": "nature", "faces": ["fire", "earth", "water", "sky", "life", ""]},
		{"name": "elemental", "type": "nature", "faces": ["fire", "earth", "water", "sky", "life", ""]},
		{"name": "elemental", "type": "nature", "faces": ["fire", "earth", "water", "sky", "life", ""]},
		{"name": "elemental", "type": "nature", "faces": ["fire", "earth", "water", "sky", "life", ""]},
		{"name": "elemental", "type": "nature", "faces": ["fire", "earth", "water", "sky", "life", ""]},
		{"name": "physical", "type": "craft", "faces": ["lob", "lob", "temper", "temper", "", ""]},
		{"name": "physical", "type": "craft", "faces": ["lob", "lob", "temper", "temper", "", ""]},
		{"name": "physical+", "type": "craft", "faces": ["lob", "lob", "lob", "temper", "temper", "temper"]},
		{"name": "magic", "type": "arcane", "faces": ["echo", "echo", "reflect", "reflect", "", ""]},
	]
	# pass a dice list to dice_inventory (raw or count unique above)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
