extends Node2D

@onready var ui: Control = $UI


var displayed: Array[Die] = []
var current_spell_selection: Array[Die] = []
var spell_queue: Array[Array] = []

func _ready() -> void:
	connect_to_global_signal_bus()

func connect_to_global_signal_bus() -> void:
	GlobalSignalBus.connect("rune_interaction",rune_interaction)

func rune_interaction(die) -> void:
	if die in current_spell_selection:
		die.set_selected(false)
		current_spell_selection.erase(die)
	elif len(current_spell_selection) < 4:
		current_spell_selection.append(die)
	else:
		#TODO alert the player that the spell is full
		die.set_selected(false)
		spell_queue.append(current_spell_selection)
		current_spell_selection = []
	ui.update_right_panel({"queue":spell_queue,"active":current_spell_selection})
