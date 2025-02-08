extends VBoxContainer

@onready var confirm: Button = $HBoxContainer/HBoxContainer/confirm
@onready var cancel: Button = $HBoxContainer/HBoxContainer/cancel

@onready var thought_preview: PanelContainer = $HBoxContainer/thought_preview


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup({"spell":[],"target":null})

func setup(spell_package:Dictionary) -> void:
	var spell = spell_package.spell
	var _target = spell_package.target
	SpellManager.get_ui_info(spell)
	thought_preview.setup(spell_package)
	if SpellManager.is_spell(spell):
		confirm.disabled = false
		cancel.disabled = false
	else:
		confirm.disabled = true
		if len(spell) > 0:
			cancel.disabled = false
		else:
			cancel.disabled = true
