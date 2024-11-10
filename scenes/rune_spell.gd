extends VBoxContainer

@onready var active_glyphs: HBoxContainer = $active_glyphs
@onready var glyph: TextureRect = $active_glyphs/glyph
@onready var glyph_2: TextureRect = $active_glyphs/glyph2
@onready var glyph_3: TextureRect = $active_glyphs/glyph3
@onready var glyph_4: TextureRect = $active_glyphs/glyph4

@onready var glyphs = [glyph, glyph_2, glyph_3,glyph_4]



func setup(spell)->void:
	for i in 4:
		if spell[i]:
			var type = spell[i].die_type
			var face = spell[i].current_glyph
			glyphs[i].texture = Global.glyph_list[type][face]
		else:
			glyphs[i].hide()
