extends Node2D

@onready var monster_manager: Node2D = $monster_manager
@onready var ui: Control = $UI
@onready var scene_player: player = $player

var battle_round:int = 0
var displayed: Array[Die] = []
var current_spell_selection: Array[Die] = []
var spell_queue: Array[Array] = []
var last_glyph_selected: Die
var action_queue:Array[Dictionary] = []
var busy:bool = false

var rewards:Dictionary = {
	"stories":1,
	"exp":100
}

var current_enemy:Monster # scene instance or just the data?
var win_state:bool = false
 
func _ready() -> void:
	connect_to_global_signal_bus()
	#TODO setup combact: however we are going to do that
	GlobalSignalBus.emit_state_change("player_turn")
	scene_player.setup(PlayerManager.export())
	print(monster_manager.get_child(0).health)
	enemy_selected(monster_manager.get_child(0))
	_update_ui()

func _process(_delta: float) -> void:
	if not busy and len(action_queue) > 0:
		for a in action_queue:
			print(a)
		busy = true
		var action = action_queue.pop_back()
		for item in action.keys():
			if item == "spell":
				cast_spell(action["spell"])
			if item == "turn_end":
				print("turn end in process!")
				action[item].call()
			if item == "monster_action":
				monster_action(action[item])
			if item == "animation":
				play_animation(action[item])
		#take action
	if win_state:
		player_wins()

func connect_to_global_signal_bus() -> void:
	GlobalSignalBus.connect("rune_interaction",rune_interaction)
	GlobalSignalBus.connect("spell_confirm",queue_spell)
	GlobalSignalBus.connect("spell_cancel",clear_spell)
	GlobalSignalBus.connect("enemy_interaction",enemy_selected)
	GlobalSignalBus.connect("enemy_death",enemy_death)
	GlobalSignalBus.connect("player_death",player_loses)
	GlobalSignalBus.connect("action_finished",process_finished_action)

func show_enemy_information()->void:
	ui.update_enemy_info(current_enemy)

func enemy_death(enemy:Monster) -> void:
	if enemy == current_enemy:
		current_enemy = null
	print("enemy died")
	if monster_manager.get_child_count() == 1:
		enemy.queue_free()
		win_state = true
	else:
		print("oh wow an anemy died! there are still more to fight!")
		enemy.queue_free()

func player_wins() -> void:
	print("player wins")
	PlayerManager.import(scene_player.export())
	PlayerManager.reward(rewards)
	get_tree().change_scene_to_file("res://scenes/liminal.tscn")

func player_loses() -> void:
	print("YOU LOSE")
	get_tree().quit()

func process_finished_action() -> void:
	busy = false


func queue_spell() -> void:
	# if spell valid
	if len(current_spell_selection) > 1 and SpellManager.is_spell(current_spell_selection):
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
	if Global.current_state == "player_turn":
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
	show_enemy_information()
	ui.update_right_panel({"queue":spell_queue,"active":current_spell_selection})
	ui.update_player_information(scene_player)

func play_animation(animation:PackedScene) -> void:
	var ani = animation.instantiate()
	ani.global_position = current_enemy.global_position
	add_child(ani)
	ani.play("default")
	await ani.animation_looped
	print("ANIMATION FINISHED")
	GlobalSignalBus.emit_action_finished()
	ani.queue_free()

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
		if current_enemy and current_enemy.health.health > 0:
			current_enemy.take_damage(spell["damage"].call())
	if spell.has("heal"):
		scene_player.heal(spell["heal"])
	if spell.has("defend"):
		scene_player.defend(spell["defend"])
	if spell.has("echo"):
		for i in range(spell["echo"]):
			print("echooooooo")
	if spell.has("effect"):
		for effect in spell["effect"]:
			print("Effect added ", {effect:spell["effect"][effect]})
			StatusManager.increase_effect(current_enemy,effect,spell["effect"][effect])
	_update_ui()
	GlobalSignalBus.emit_action_finished()



func player_turn_end() -> void:
	print("player turn end")
	GlobalSignalBus.emit_state_change("enemy_turn")
	enemy_turn()
	GlobalSignalBus.emit_action_finished()

func enemy_turn_end() -> void:
	GlobalSignalBus.emit_action_finished()
	GlobalSignalBus.emit_revert_state()


func enemy_turn() -> void:
	print("enemy turn start")
	for monster:Monster in monster_manager.get_children():
		print("monster turn added to queue ", monster)
		add_action_to_queue({"monster_action":monster})
	add_action_to_queue({"turn_end": func (): enemy_turn_end()})

func monster_action(monster:Monster) -> void:
	if monster.is_alive():
		print(monster.monster_name, " takes its turn")
		#TODO damage to player
		var action = monster.actions[monster.current_action_index]
		print(monster.monster_name, " takes the action: ",action["name"])
		if action.keys().has("attack"):
			scene_player.take_damage(action["attack"].call())
			print(scene_player.health, " health left")
		if action.keys().has("defence"):
			monster.defend(action["defence"])
		if action.keys().has("heal"):
			monster.heal(action["heal"])
		if action.keys().has("effect"):
			for effect in action["effect"].keys():
				print("Effect added ", {effect:action["effect"][effect]})
				StatusManager.increase_effect(scene_player,effect,action["effect"][effect])
	_update_ui()
	GlobalSignalBus.emit_action_finished()

func _on_right_panel_cast() -> void:
	if current_enemy and Global.current_state == "player_turn":
		print("SPELL C-C-C-C-C-C-COMBO")
		for spell in spell_queue:
			var effect = SpellManager.effect_generation(spell)
			print("effect: ",effect)
			if effect.keys().has("animation"):
				add_action_to_queue({"animation":effect.animation})
			add_action_to_queue({"spell":effect})
		_update_ui()
	else:
		print("please select a monster")
	add_action_to_queue({"turn_end":func ():player_turn_end()})


func add_action_to_queue(item:Dictionary) -> void:
	action_queue.insert(0,item)


func _on_right_panel_clear_all() -> void:
	clear_queue()


func _on_right_panel_clear_last() -> void:
	clear_last_spell()


func _on_player_turn_round_start() -> void:
	clear_queue()
	battle_round += 1
	print("Round ", battle_round, " ~start!~ ")
	scene_player.start_turn()
	for monster:Monster in monster_manager.get_children():
		monster.start_turn()
	_update_ui()
	GlobalSignalBus.emit_action_finished()
	


func _on_active_panel_shook() -> void:
	clear_spell()
