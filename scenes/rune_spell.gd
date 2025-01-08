extends VBoxContainer

@onready var active_glyphs: HBoxContainer = $active_glyphs
@onready var glyph: TextureRect = $active_glyphs/glyph
@onready var glyph_2: TextureRect = $active_glyphs/glyph2
@onready var glyph_3: TextureRect = $active_glyphs/glyph3
@onready var glyph_4: TextureRect = $active_glyphs/glyph4

@onready var glyphs = [glyph, glyph_2, glyph_3,glyph_4]
@onready var effects: Label = $effects
@onready var power_ups: Label = $"power-ups"
@onready var target_label: Label = $target

func _ready() -> void:
	setup({"spell":[],"target":''})

func setup(spell_package:Dictionary)->void:
	var spell = spell_package.spell
	var target = spell_package.target
	#print("called setup for rune spell")
	#print("the spell is ",spell)
	if target and spell != []:
		target_label.text = "Target: " + target.monster_name
	else:
		target_label.text = ''
	for i in 4:
		if len(spell) > i:
			glyphs[i].texture = spell[i].texture
			glyphs[i].show()
		else:
			glyphs[i].hide()
			
	if SpellManager.is_spell(spell):
		var spell_info = SpellManager.get_ui_info(spell)
		effects.text = spell_info["name"] + ": "
		for key in spell_info.keys():
			if key == "damage":
				var damage_info = spell_info["damage"].call()
				effects.text += str(damage_info.damage) + " " + damage_info.type + " Damage"
			if key == "effect":
				for  effect in spell_info["effect"].keys():
					effects.text += effect + " "
			if key == "defend":
				effects.text += "get " + str(spell_info["defend"]) + " defense"
			if key == "heal":
				effects.text += "heals for " + str(spell_info["heal"])
			if key == "reflect":
				effects.text += "Reflects damage"
		self.tooltip_text = effects.text
	else:
		effects.text = ""
		self.tooltip_text = effects.text
		


func _on_confirm_pressed() -> void:
	GlobalSignalBus.emit_spell_confirm()

func _on_cancel_pressed() -> void:
	GlobalSignalBus.emit_spell_cancel()
