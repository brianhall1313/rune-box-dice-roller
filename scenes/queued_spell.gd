extends HBoxContainer

@onready var thought_preview: PanelContainer = $thought_preview


func setup(spell_package:Dictionary)->void:
	thought_preview.setup(spell_package)
