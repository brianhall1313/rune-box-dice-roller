extends Node



signal state_change(new_state:String)
signal revert_state

signal enemy_interaction(enemy:Monster)
signal rune_interaction(rune)

signal spell_confirm
signal spell_cancel
signal player_death


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
