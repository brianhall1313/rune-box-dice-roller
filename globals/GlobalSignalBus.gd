extends Node



signal state_change(new_state:String)
signal revert_state

signal enemy_interaction(enemy:Monster)
signal rune_interaction(rune)

signal add_effect(effect:PackedScene,target)

signal spell_confirm
signal spell_cancel
signal player_death
signal enemy_death(enemy:Monster)

signal display_damage(damage:Damage, pos:Vector2)

signal level_selected(levelID:int)

signal action_finished

signal interrupt_action(action:Dictionary)

func emit_state_change(new_state:String) -> void:
	state_change.emit(new_state)

func emit_revert_state() -> void:
	revert_state.emit()
func emit_enemy_interaction(enemy:Monster) -> void:
	enemy_interaction.emit(enemy)
func emit_rune_interaction(rune) -> void:
	rune_interaction.emit(rune)
func emit_spell_confirm() -> void:
	spell_confirm.emit()
func emit_spell_cancel() -> void:
	spell_cancel.emit()
func emit_player_death() -> void:
	player_death.emit()
func emit_enemy_death(enemy:Monster) -> void:
	enemy_death.emit(enemy)
func emit_action_finished() -> void:
	action_finished.emit()
func emit_level_selected(levelID:int) -> void:
	level_selected.emit(levelID)
func emit_add_effect(effect:PackedScene,target) -> void:
	add_effect.emit(effect,target)
func emit_display_damage(damage:Damage,pos:Vector2) -> void:
	display_damage.emit(damage,pos)
func emit_interrupt_action(action:Dictionary) -> void:
	interrupt_action.emit(action)
