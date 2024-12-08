extends Control

@onready var box: Control = $HBoxContainer/box
@onready var shake_box: Button = $HBoxContainer/VBoxContainer/shake_box

signal shook

func toggle_shake(active:bool)->void:
	shake_box.disabled = !active

func _on_shake_box_button_up() -> void:
	print("shake button pressed")
	box.shake_box()
	shook.emit()
