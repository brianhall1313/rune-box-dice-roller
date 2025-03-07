extends Control

@onready var name_entry: LineEdit = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/name_entry
@onready var error: TextureRect = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/error
@onready var body: VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/portrait_editor/GridContainer/body
@onready var outfit: VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/portrait_editor/GridContainer/outfit
@onready var hat: VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/portrait_editor/GridContainer/hat
@onready var ears: VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/portrait_editor/GridContainer/ears
@onready var eyes: VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/portrait_editor/GridContainer/eyes

@onready var player_portrait: TextureRect = $PanelContainer/MarginContainer/VBoxContainer/portrait_editor/player_portrait

@onready var error_symbol:CompressedTexture2D = preload("res://textures/error.png")

var custom_options:Dictionary ={
	"Body":0,
	"Outfit":0,
	"Ears":0,
	"Hat":0,
	"Eyes":0
}
var update = true

#func _ready() -> void:
	#to_default()

func _process(_delta: float) -> void:
	if update:
		update = false
		update_portrait()


func to_default() -> void:
	for item in custom_options.keys():
		custom_options[item] = 0
	update_portrait()


func update_portrait() -> void:
	player_portrait.setup(custom_options)

func decrement(slot) -> void:
	if (slot == "Body" or slot == "Eyes") and custom_options[slot] == 0:
		custom_options[slot] = len(Global.colors)-1
	elif custom_options[slot] == 0:
		custom_options[slot] = len(Global.player_customization[slot])-1
	else:
		custom_options[slot] -= 1
	update_portrait()

func increment(slot) -> void:
	if (slot == "Body" or slot == "Eyes") and custom_options[slot] == len(Global.colors)-1:
		custom_options[slot] = 0
	elif slot != "Body" and slot != "Eyes" and custom_options[slot] == len(Global.player_customization[slot])-1:
		custom_options[slot] = 0
	else:
		custom_options[slot] += 1
	update_portrait()

func _on_name_entry_text_submitted(_new_text: String) -> void:
	name_entry.release_focus()


func _on_confirm_button_up() -> void:
	if name_entry.text == "":
		print("no name entered")
		error.texture = error_symbol
		#play error sound, maybe make symbol jiggle?
		return
	PlayerManager.create_player({
		"name":name_entry.text,
		"portrait":custom_options.duplicate()
		})
	get_tree().change_scene_to_file("res://scenes/overworld.tscn")


func _on_name_entry_text_changed(_new_text: String) -> void:
	error.texture = null


func _on_body_decrement() -> void:
	decrement("Body")
	body.update(custom_options["Body"])


func _on_body_increment() -> void:
	increment("Body")
	body.update(custom_options["Body"])


func _on_outfit_decrement() -> void:
	decrement("Outfit")
	outfit.update(custom_options["Outfit"])


func _on_outfit_increment() -> void:
	increment("Outfit")
	outfit.update(custom_options["Outfit"])


func _on_hat_decrement() -> void:
	decrement("Hat")
	hat.update(custom_options["Hat"])


func _on_hat_increment() -> void:
	increment("Hat")
	hat.update(custom_options["Hat"])


func _on_ears_decrement() -> void:
	decrement("Ears")
	ears.update(custom_options["Ears"])


func _on_ears_increment() -> void:
	increment("Ears")
	ears.update(custom_options["Ears"])


func _on_randomize_button_up() -> void:
	for slot in custom_options.keys():
		if slot == "Body" or slot == "Eyes":
			custom_options[slot] = randi_range(0,len(Global.colors)-1)
		else:
			custom_options[slot] = randi_range(0,len(Global.player_customization[slot])-1)
	
	body.update(custom_options["Body"])
	outfit.update(custom_options["Outfit"])
	hat.update(custom_options["Hat"])
	ears.update(custom_options["Ears"])
	eyes.update(custom_options["Eyes"])
	update_portrait()


func _on_go_back_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_eyes_decrement() -> void:
	decrement("Eyes")
	eyes.update(custom_options["Eyes"])


func _on_eyes_increment() -> void:
	increment("Eyes")
	eyes.update(custom_options["Eyes"])


func _on_default_button_up() -> void:
	to_default()
