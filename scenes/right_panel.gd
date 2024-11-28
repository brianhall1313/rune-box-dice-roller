extends Control

@onready var active_spell: VBoxContainer = $VBoxContainer/spell_information/active_spell
@onready var queued_spells: VBoxContainer = $VBoxContainer/spell_information/queued_spells

@onready var active_spell_box: PackedScene=preload("res://scenes/active_spell.tscn")
@onready var queued_spell_box: PackedScene = preload("res://scenes/queued_spell.tscn")

@onready var enemy_info_container: VBoxContainer = $VBoxContainer/enemy_info_container

signal cast
signal clear_all
signal clear_last


func update(args:Dictionary)->void:
	if args.has("spell"):
		print(args["spell"])
		for child in queued_spells.get_children():
			child.queue_free()
		for spell in args["spell"]["queue"]:
			var new = queued_spell_box.instantiate()
			queued_spells.add_child(new)
			new.get_child(0).setup(spell)
		print("want to update active spell too")
		print(args["spell"]["active"])
		active_spell.get_child(0).get_child(0).setup(args["spell"]["active"])
	if args.has("enemy"):
		enemy_info_container.update(args["enemy"])


func _on_cast_button_up() -> void:
	cast.emit()


func _on_clear_last_button_up() -> void:
	clear_last.emit()


func _on_clear_all_button_up() -> void:
	clear_all.emit()
