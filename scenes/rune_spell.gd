extends VBoxContainer

@onready var active_glyphs: HBoxContainer = $active_glyphs
@onready var glyph: TextureRect = $active_glyphs/glyph
@onready var glyph_2: TextureRect = $active_glyphs/glyph2
@onready var glyph_3: TextureRect = $active_glyphs/glyph3
@onready var glyph_4: TextureRect = $active_glyphs/glyph4

@onready var glyphs = [glyph, glyph_2, glyph_3,glyph_4]



func setup(spell)->void:
	print("called setup for ", self)
	print("the spell is ",spell)
	for i in 4:
		print("i is ", i)
		if len(spell) > i:
			glyphs[i].texture = spell[i].texture
			glyphs[i].show()
		else:
			glyphs[i].hide()


func _on_confirm_pressed() -> void:
	GlobalSignalBus.spell_confirm.emit()
	 # Replace with function body.

func _on_cancel_pressed() -> void:
	GlobalSignalBus.spell_cancel.emit() # Replace with function body.
