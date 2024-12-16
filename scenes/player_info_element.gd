extends Control

@onready var player_portrait = $VBoxContainer/player_info/player_portrait
@onready var player_name = $VBoxContainer/player_info/player_name
# Called when the node enters the scene tree for the first time.
@onready var player_health: ProgressBar = $VBoxContainer/player_health
# this is so you can add and delete effects easily
@onready var effect_point: Control = $effect_point
@onready var health_label: Label = $VBoxContainer/health_label
@onready var effects_info: Label = $VBoxContainer/effects_info

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

func update_player_information(scene_player:player)->void:
	player_health.max_value = scene_player.health.max_health
	player_health.value = scene_player.health.health
	health_label.text = "HP: " + str(scene_player.health.health)+" / " + str(scene_player.health.max_health)
	effects_info.text = ""
	for effect in scene_player.status:
		effects_info.text += effect + ": " + str(scene_player.status[effect]) + "\n"

func add_effect(effect:PackedScene) -> void:
	var ani = effect.instantiate()
	effect_point.add_child(ani)
	ani.global_position = effect_point.global_position

func remove_effect() -> void:
	for child in effect_point.get_children():
		child.queue_free()
