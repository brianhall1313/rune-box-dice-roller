extends Control

@onready var box: Control = $HBoxContainer/box

func _on_shake_box_button_up() -> void:
	print("shake button pressed")
	box.shake_box()
