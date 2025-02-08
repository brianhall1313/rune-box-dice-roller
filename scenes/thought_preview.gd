extends PanelContainer

@onready var rune_spell: VBoxContainer = $rune_spell


func setup(spell_package:Dictionary)->void:
	rune_spell.setup(spell_package)
