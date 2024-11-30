extends State

signal round_start

func enter()->void:
	round_start.emit()

func exit()->void:
	pass

func handle_input(_event:InputEvent)->void:
	pass
