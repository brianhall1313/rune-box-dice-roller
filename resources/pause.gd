extends State


func enter()->void:
	pass

func exit()->void:
	pass

func handle_input(event:InputEvent)->void:
	if event.is_action_released("undo"):
		GlobalSignalBus.revert_state.emit()
