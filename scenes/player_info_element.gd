extends Control
@onready var player_portrait: TextureRect = $VBoxContainer/player_info/player_portrait

@onready var player_name = $VBoxContainer/player_info/player_name
# Called when the node enters the scene tree for the first time.
@onready var player_health: ProgressBar = $VBoxContainer/player_health
# this is so you can add and delete effects easily
@onready var effect_point: Control = $effect_point
@onready var health_label: Label = $VBoxContainer/health_label
@onready var effects_info: Label = $VBoxContainer/effects_info
@onready var defense_label: Label = $VBoxContainer/defense_label


var dice_list = []
func _ready() -> void:
	# set this on load/new in some global state and use it here
	player_name.text = PlayerManager.player_name
	player_portrait.setup(PlayerManager.custom_options)
	
	# and set the dice list to a bunch of real stuff (loaded or initial)
	# dice_list = InventoryManager.inventory
	# pass a dice list to dice_inventory (raw or count unique above)

func update_player_information(scene_player:player)->void:
	player_health.max_value = scene_player.health.max_health
	player_health.value = scene_player.health.health
	health_label.text = "HP: " + str(scene_player.health.health)+" / " + str(scene_player.health.max_health)
	effects_info.text = ""
	if scene_player.health.defense > 0:
		defense_label.text = str(scene_player.health.defense) + " Defense"
	else:
		defense_label.text = ""
	for effect in scene_player.status:
		effects_info.text += effect + ": " + str(scene_player.status[effect]) + "\n"

func add_effect(effect:PackedScene) -> void:
	var ani = effect.instantiate()
	effect_point.add_child(ani)
	ani.global_position = effect_point.global_position

func remove_effect() -> void:
	for child in effect_point.get_children():
		child.queue_free()
