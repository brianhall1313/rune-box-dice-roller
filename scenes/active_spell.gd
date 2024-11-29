extends VBoxContainer

@onready var confirm: Button = $HBoxContainer/confirm
@onready var cancel: Button = $HBoxContainer/cancel
@onready var rune_spell: VBoxContainer = $HBoxContainer/rune_spell


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup([])

func setup(spell:Array) -> void:
	rune_spell.setup(spell)
	if len(spell) == 0:
		confirm.disabled = true
		cancel.disabled = true
	elif len(spell) == 1:
		confirm.disabled = true
		cancel.disabled = false
	else:
		confirm.disabled = false
		cancel.disabled = false
