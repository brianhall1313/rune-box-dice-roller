extends Control

@onready var active_spell: VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/spell_information/active_spell
@onready var queued_spells: VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/spell_information/queued_spells_container/queued_spells


@onready var active_spell_box: PackedScene=preload("res://scenes/active_spell.tscn")
@onready var queued_spell_box: PackedScene = preload("res://scenes/queued_spell.tscn")

@onready var interact_buttons: HBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/interact_buttons

signal cast
signal clear_all
signal clear_last


func _ready() -> void:
	update({"spell":{"queue":[],"active":{"spell":[],"target":null}}})

func update(args:Dictionary)->void:
	if args.has("spell"):
		#print(args["spell"])
		for child in queued_spells.get_children():
			child.queue_free()
		for spell in args["spell"]["queue"]:
			var new = queued_spell_box.instantiate()
			queued_spells.add_child(new)
			new.setup(spell)
		#print("want to update active spell too")
		print(args["spell"]["active"])
		if len(args["spell"]["active"]["spell"])>0:
			active_spell.show()
			active_spell.setup(args["spell"]["active"])
			return
		active_spell.hide()



func _on_cast_button_up() -> void:
	#print("cast button hit from right_panel")
	cast.emit()


func _on_clear_last_button_up() -> void:
	clear_last.emit()


func _on_clear_all_button_up() -> void:
	clear_all.emit()
