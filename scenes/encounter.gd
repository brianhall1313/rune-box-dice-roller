extends Node2D


var displayed: Array[Object] = []
var current_spell_selection: Array[Object] = []
var spell_queue: Array[Array] = []

func _ready() -> void:
	connect_to_global_signal_bus()

func connect_to_global_signal_bus() -> void:
	GlobalSignalBus.connect("rune_interaction",rune_interaction)

func rune_interaction(rune) -> void:
	pass
