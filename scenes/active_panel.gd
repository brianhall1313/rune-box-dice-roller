extends Control

@onready var box: Control = $HBoxContainer/box
@onready var shake_box_button: Button = $HBoxContainer/VBoxContainer/shake_box

signal shook

func toggle_shake(active:bool)->void:
	shake_box_button.disabled = !active

func _on_shake_box_button_up() -> void:
	print("shake button pressed")
	box.shake_box()
	shook.emit()

func shake_box() -> void:
	box.shake_box()

func update(shift_spends_available:bool) -> void:
	toggle_shake(shift_spends_available)
