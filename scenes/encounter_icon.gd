extends VBoxContainer

@export var encounterID: int

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_released("click"):
		GlobalSignalBus.emit_level_selected(encounterID)
		
