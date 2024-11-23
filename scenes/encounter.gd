extends Node2D

@onready var monster_manager: Node2D = $monster_manager
@onready var ui: Control = $UI


var displayed: Array[Die] = []
var current_spell_selection: Array[Die] = []
var spell_queue: Array[Array] = []
var last_glyph_selected: Die

var current_enemy:Monster # scene instance or just the data?

func _ready() -> void:
	connect_to_global_signal_bus()

func connect_to_global_signal_bus() -> void:
	GlobalSignalBus.connect("rune_interaction",rune_interaction)
	GlobalSignalBus.connect("spell_confirm",queue_spell)
	GlobalSignalBus.connect("spell_cancel",clear_spell)
	GlobalSignalBus.connect("enemy_interaction",enemy_selected)

func show_enemy_information()->void:
	if current_enemy:
		ui.update_enemy_info(current_enemy)


func queue_spell() -> void:
	# if spell valid
	if len(current_spell_selection) > 1:
		spell_queue.append(current_spell_selection)
		current_spell_selection = []
	_update_ui()
	
func clear_spell() -> void:
	for die in current_spell_selection:
		die.set_selected(false)
	current_spell_selection = []
	_update_ui()

func rune_interaction(die) -> void:
	if die in current_spell_selection:
		die.set_selected(false)
		current_spell_selection.erase(die)
		if len(current_spell_selection) > 0:
			last_glyph_selected = current_spell_selection[len(current_spell_selection)-1]
		else:
			last_glyph_selected = null
	elif len(current_spell_selection) == 0:
		current_spell_selection.append(die)
		die.set_selected(true)
		last_glyph_selected = die
	elif len(current_spell_selection) < 2:
		print("want to append a die")
		if die in last_glyph_selected.adjacent.values():
			current_spell_selection.append(die)
			die.set_selected(true)
			last_glyph_selected = die
		
		print("new spell length ", len(current_spell_selection))
	else:
		#TODO alert the player that the spell is full
		die.set_selected(false)
	_update_ui()

func _update_ui():
	print(current_spell_selection)
	ui.update_right_panel({"queue":spell_queue,"active":current_spell_selection})

func enemy_selected(enemy:Monster) -> void:
	current_enemy = enemy
	show_enemy_information()
