extends Node2D

@onready var monster_manager: Node2D = $monster_manager
@onready var ui: Control = $UI
@onready var scene_player: player = $player
@onready var action_delay: Timer = $action_delay

var battle_round:int = 0
var displayed: Array[Die] = []
var current_spell_selection: Array[Die] = []
var spell_queue: Array[Dictionary] = []
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
	setup()
	GlobalSignalBus.emit_state_change("player_turn")
	scene_player.setup(PlayerManager.export())
	enemy_selected(monster_manager.get_child(0))
	round_start()
	_update_ui()

func _process(_delta: float) -> void:
	if not busy and (len(action_queue) > 0) and action_delay.is_stopped():
		for a in action_queue:
			print("action: ", a)
		print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
		busy = true
		action_delay.start()
		var action = action_queue.pop_back()
		for item in action.keys():
			action[item].call()
		#take action
	if win_state:
		player_wins()

func setup() -> void:
	var encounter = EncounterDirectory.encounters[Global.next_level]
	for enemy in encounter.enemies:
		var new = EncounterDirectory.monster_directory[enemy.enemy].instantiate()
		new.monster_name = enemy.name
		monster_manager.add_child(new)
		new.global_position = enemy.position

func connect_to_global_signal_bus() -> void:
	GlobalSignalBus.connect("rune_interaction",rune_interaction)
	GlobalSignalBus.connect("spell_confirm",queue_spell)
	GlobalSignalBus.connect("spell_cancel",clear_spell)
	GlobalSignalBus.connect("enemy_interaction",enemy_selected)
	GlobalSignalBus.connect("enemy_death",enemy_death)
	GlobalSignalBus.connect("player_death",player_loses)
	GlobalSignalBus.connect("action_finished",process_finished_action)
	GlobalSignalBus.connect("add_effect",add_effect)
	GlobalSignalBus.connect("display_damage",display_damage)
	GlobalSignalBus.connect("interrupt_action",add_interrupt_action_to_queue)

func show_enemy_information()->void:
	ui.update_enemy_info(current_enemy)

func enemy_death(enemy:Monster) -> void:
	if enemy == current_enemy:
		current_enemy = get_next_alive_enemy()
	#print("enemy died")
	if current_enemy == null:
		enemy.queue_free()
		win_state = true
	else:
		#print("oh wow an anemy died! there are still more to fight!")
		enemy.queue_free()

func player_wins() -> void:
	#print("player wins")
	PlayerManager.import(scene_player.export())
	PlayerManager.reward(rewards)
	PlayerManager.save_player()
	get_tree().change_scene_to_file("res://scenes/overworld.tscn")

func player_loses() -> void:
	#print("YOU LOSE")
	get_tree().quit()

func process_finished_action() -> void:
	busy = false

func get_next_alive_enemy():
	for monster in monster_manager.get_children():
		if monster.health.health > 0:
			enemy_selected(monster)
			return monster
	return null

func queue_spell() -> void:
	# if spell valid
	if SpellManager.is_spell(current_spell_selection):
		var target
		if SpellManager.effect_generation(current_spell_selection).keys().has("attack_animation"):
			target = current_enemy
		else:
			target = scene_player
		var spell = {
			"spell":current_spell_selection,
			"target":target
		}
		spell_queue.append(spell)
		current_spell_selection = []
		_update_ui()
	ui.toggle_shake(false)
	
func clear_spell() -> void:
	for die in current_spell_selection:
		die.set_selected(false)
	current_spell_selection = []
	_update_ui()

func check_per_action(actor) ->void:
	for status in actor.status.keys():
		if StatusManager.per_action.keys().has(status):
			StatusManager.per_action[status].call(actor)
			if StatusManager.effects_list.keys().has(status):
				#print("playing effect")
				add_effect(StatusManager.effects_list[status],actor)
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
	ui.update_right_panel({"queue":spell_queue,"active":{"spell":current_spell_selection,"target":current_enemy}})
	ui.update_player_information(scene_player)

func play_animation(animation:PackedScene,target=null,is_player:bool=false) -> void:
	GlobalSignalBus.emit_state_change("animation_playing")
	var ani = animation.instantiate()
	if is_player:
		#print("animation effecting player")
		ani.global_position = ui.player_point.global_position
	else:
		if !target:
			target = get_next_alive_enemy()
		ani.global_position = target.hit_position.global_position
	add_child(ani)
	ani.play("default")
	await ani.animation_looped
	GlobalSignalBus.emit_action_finished()
	ani.queue_free()
	GlobalSignalBus.emit_revert_state()
	action_delay.stop()

func add_effect(effect:PackedScene,target:Node) -> void:
	GlobalSignalBus.emit_state_change("animation_playing")
	if target == scene_player:
		ui.add_effect_to_player(effect)
	else:
		target.add_effect(effect)
	GlobalSignalBus.emit_revert_state()
	GlobalSignalBus.emit_action_finished()
	action_delay.stop()

func enemy_selected(enemy:Monster) -> void:
	if current_enemy:
		current_enemy.selected()
	current_enemy = enemy
	current_enemy.selected()
	_update_ui()

func clear_queue() -> void:
	for spell in spell_queue:
		for die:Die in spell.spell:
			die.set_selected(false)
	spell_queue = []
	#print("queue cleared")
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

func cast_spell(spell_package)->void:
	check_per_action(scene_player)
	var spell = spell_package.spell
	var target = spell_package.target
	if !is_instance_valid(target):
		target = get_next_alive_enemy()
	if spell.has("damage"):
		if target and target.health.health > 0:
			target.take_damage(spell["damage"].call())
	if spell.has("heal"):
		scene_player.heal(spell["heal"])
	if spell.has("defend"):
		scene_player.defend(spell["defend"])
	if spell.has("echo"):
		for i in range(spell["echo"]):
			print("echooooooo")
	if spell.has("effect"):
		for effect in spell["effect"]:
			#print("Effect added ", {effect:spell["effect"][effect]})
			StatusManager.increase_effect(target,effect,spell["effect"][effect])
	_update_ui()
	GlobalSignalBus.emit_action_finished()

func display_message(message:String) -> void:
	ui.display_message(message)

func round_start() -> void:
	clear_queue()
	battle_round += 1
	ui.shake_box()
	print("Round ", battle_round, " ~start!~ ")
	print("this is the only revert that should happen at the end of a turn")
	#this should revery enemy turn to player turn
	if battle_round > 1:
		GlobalSignalBus.emit_revert_state()
	scene_player.start_turn()
	for monster:Monster in monster_manager.get_children():
		monster.start_turn()
	_update_ui()
	GlobalSignalBus.emit_action_finished()

func player_turn_end() -> void:
	print("player turn end")
	GlobalSignalBus.emit_state_change("enemy_turn")
	#I feel like I should find a better place to reset defense
	for enemy:Monster in monster_manager.get_children():
		enemy.reset_defense()
	enemy_turn()
	GlobalSignalBus.emit_action_finished()

func enemy_turn_end() -> void:
	GlobalSignalBus.emit_action_finished()
	round_start()


func enemy_turn() -> void:
	print("enemy turn start")
	for monster:Monster in monster_manager.get_children():
		#print("monster turn added to queue ", monster)
		var action = monster.get_action()
		add_action_to_queue({"damage_animation":func ():
			display_message(action["name"])
			play_animation(Global.damage_animations[action["damage_animation"]],player,true),"monster_attack_animation":func():monster.play_animation("attack")})
		add_action_to_queue({"monster_action":func (): monster_action(monster)})
	add_action_to_queue({"turn_end": func (): enemy_turn_end()})

func monster_action(monster:Monster) -> void:
	if monster.is_alive():
		#print(monster.monster_name, " takes its turn")
		var action = monster.get_action()
		if action:
			check_per_action(monster)
		print(monster.monster_name, " takes the action: ",action["name"])
		if action.keys().has("attack"):
			scene_player.take_damage(action["attack"].call())
			#print(scene_player.health, " health left")
		if action.keys().has("defence"):
			monster.defend(action["defence"])
		if action.keys().has("heal"):
			monster.heal(action["heal"])
		if action.keys().has("effect"):
			for effect in action["effect"].keys():
				#print("Effect added ", {effect:action["effect"][effect]})
				StatusManager.increase_effect(scene_player,effect,action["effect"][effect])
	_update_ui()
	GlobalSignalBus.emit_action_finished()

func _on_right_panel_cast() -> void:
	if current_enemy and Global.current_state == "player_turn":
		#print("SPELL C-C-C-C-C-C-COMBO")
		for spell in spell_queue:
			var effect = SpellManager.effect_generation(spell.spell)
			#print("effect: ",effect)
			if effect.keys().has("attack_animation"):
				add_action_to_queue({"attack_animation":
					func (): 
						display_message(effect.name)
						play_animation(effect.attack_animation,spell.target)
						})
			if effect.keys().has("defense_animation"):
				add_action_to_queue({"defense_animation":
					func(): 
						display_message(effect.name)
						add_effect(effect.defense_animation,scene_player)})
			add_action_to_queue({"spell":func(): cast_spell({"spell":effect,"target":spell.target})})
		add_action_to_queue({"turn_end":func ():player_turn_end()})
		_update_ui()
	else:
		print("please select a monster")


func add_action_to_queue(item:Dictionary) -> void:
	action_queue.insert(0,item)

func add_interrupt_action_to_queue(item:Dictionary) -> void:
	action_queue.insert(len(action_queue),item)

func _on_right_panel_clear_all() -> void:
	clear_queue()


func _on_right_panel_clear_last() -> void:
	clear_last_spell()



func _on_active_panel_shook() -> void:
	clear_spell()


func _on_player_defense_gone() -> void:
	ui.remove_effect_from_player()


func _on_player_took_damage(damage:Damage) -> void:
	ui.player_took_damage(damage)

func display_damage(damage:Damage,pos:Vector2) -> void:
	var new = Global.damage_number_label.instantiate()
	add_child(new)
	new.global_position = pos
	new.display(damage)
