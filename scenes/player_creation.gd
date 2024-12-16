extends Control

@onready var name_entry: LineEdit = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/name_entry
@onready var error: TextureRect = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/error

@onready var error_symbol:CompressedTexture2D = preload("res://textures/error.png")

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
		"portrait":null
		})


func _on_name_entry_text_changed(new_text: String) -> void:
	error.texture = null
