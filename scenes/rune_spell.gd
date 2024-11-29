extends VBoxContainer

@onready var active_glyphs: HBoxContainer = $active_glyphs
@onready var glyph: TextureRect = $active_glyphs/glyph
@onready var glyph_2: TextureRect = $active_glyphs/glyph2
@onready var glyph_3: TextureRect = $active_glyphs/glyph3
@onready var glyph_4: TextureRect = $active_glyphs/glyph4

@onready var glyphs = [glyph, glyph_2, glyph_3,glyph_4]
@onready var effects: Label = $effects
@onready var power_ups: Label = $"power-ups"

func _ready() -> void:
	setup([])

func setup(spell)->void:
	print("called setup for ", self)
	print("the spell is ",spell)
	for i in 4:
		if len(spell) > i:
			glyphs[i].texture = spell[i].texture
			glyphs[i].show()
		else:
			glyphs[i].hide()
			
	effects.text = ""#TODO update to spell description text


func _on_confirm_pressed() -> void:
	GlobalSignalBus.emit_spell_confirm()

func _on_cancel_pressed() -> void:
	GlobalSignalBus.emit_spell_cancel()
