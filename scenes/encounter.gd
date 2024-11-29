extends Node2D

@onready var monster_manager: Node2D = $monster_manager
@onready var ui: Control = $UI
@onready var scene_player: player = $player


var displayed: Array[Die] = []
var current_spell_selection: Array[Die] = []
var spell_queue: Array[Array] = []
var last_glyph_selected: Die

var current_enemy:Monster # scene instance or just the data?

func _ready() -> void:
	connect_to_global_signal_bus()
	#TODO setup combact: however we are going to do that
	GlobalSignalBus.emit_state_change("test")
	scene_player.setup(PlayerManager.export())
	print(monster_manager.get_child(0).health)
	enemy_selected(monster_manager.get_child(0))
	_update_ui()

func connect_to_global_signal_bus() -> void:
	GlobalSignalBus.connect("rune_interaction",rune_interaction)
	GlobalSignalBus.connect("spell_confirm",queue_spell)
	GlobalSignalBus.connect("spell_cancel",clear_spell)
	GlobalSignalBus.connect("enemy_interaction",enemy_selected)
	GlobalSignalBus.connect("enemy_death",enemy_death)

func show_enemy_information()->void:
	if current_enemy:
		ui.update_enemy_info(current_enemy)

func enemy_death(enemy:Monster) -> void:
	if enemy == current_enemy:
		current_enemy = null
	print("enemy died")
	if monster_manager.get_child_count() == 1:
		enemy.queue_free()
		print("you win!!")
	else:
		print("oh wow an anemy died! there are still more to fight!")
		enemy.queue_free()

func queue_spell() -> void:
	# if spell valid
	if len(current_spell_selection) > 1:
		spell_queue.append(current_spell_selection)
		current_spell_selection = []
	_update_ui()
	ui.toggle_shake(false)
	
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
		if die in last_glyph_selected.adjacent.values():
			current_spell_selection.append(die)
			die.set_selected(true)
			last_glyph_selected = die
	else:
		#TODO alert the player that the spell is full
		die.set_selected(false)
	_update_ui()

func _update_ui():
	if current_enemy:
		show_enemy_information()
	ui.update_right_panel({"queue":spell_queue,"active":current_spell_selection})

func enemy_selected(enemy:Monster) -> void:
	if current_enemy:
		current_enemy.selected()
	current_enemy = enemy
	current_enemy.selected()
	_update_ui()

func clear_queue() -> void:
	for spell in spell_queue:
		for die:Die in spell:
			die.set_selected(false)
	spell_queue = []
	print("queue cleared")
	_update_ui()
	ui.toggle_shake(true)

func clear_last_spell() -> void:
	if len(spell_queue) > 0:
		var spell:Array[Die] = spell_queue.pop_back()
		for die:Die in spell:
			die.set_selected(false)
	_update_ui()
	if len(spell_queue) == 0:
		ui.toggle_shake(true)

func cast_spell(spell)->void:
	if spell.has("damage"):
		print("sending ",spell["damage"]," damage")
		current_enemy.take_damage(spell["damage"])
	if spell.has("heal"):
		scene_player.heal(spell["heal"])
	if spell.has("defned"):
		scene_player.defend(spell["defend"])
	if spell.has("echo"):
		for i in range(spell["echo"]):
			print("echooooooo")

func _on_right_panel_cast() -> void:
	print("cast button pressed from encounter")
	if current_enemy:
		print("SPELL C-C-C-C-C-C-COMBO")
		for spell in spell_queue:
			var effect = SpellManager.effect_generation(spell)
			print("effect: ",effect)
			cast_spell(effect)
			_update_ui()
	else:
		print("please select a monster")
	#TODO monster turn


func _on_right_panel_clear_all() -> void:
	clear_queue()


func _on_right_panel_clear_last() -> void:
	clear_last_spell()
