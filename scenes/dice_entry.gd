extends VBoxContainer

@onready var full_dice_view: VBoxContainer = $full_dice_view


func _gui_input(event: InputEvent) -> void:
	if event.is_action_released("click"):
		full_dice_view.visible = !full_dice_view.visible

func setup() -> void:
	pass
