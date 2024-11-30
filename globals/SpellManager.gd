extends Node

var spell_effects:Dictionary={
	"fire":{"damage":10},
	"water":{"damage":10},
	"earth":{"damage":10},
	"sky":{"damage":10},
	"life":{"heal":10},
	"lob":{"damage":10},
	"temper":{"defend":10},
	"reflect":{"defend":10},
	"echo":{"echo":1}
}

func effect_generation(spell) -> Dictionary:
	#TODO alpha mode! we still need effects and stuff in here too, as well as an actual spell list instead of this simplistic one
	var translated_spell:Dictionary ={}
	for die:Die in spell:
		if spell_effects[die.current_glyph].has("damage"):
			if translated_spell.has("damage"):
				translated_spell["damage"].damage += spell_effects[die.current_glyph]["damage"]
			else:
				translated_spell["damage"] = Global.damage.new(spell_effects[die.current_glyph]["damage"],die.current_glyph)
		elif spell_effects[die.current_glyph].has("heal"):
			if translated_spell.has("heal"):
				translated_spell["heal"] += spell_effects[die.current_glyph]["heal"]
			else:
				translated_spell["heal"] = spell_effects[die.current_glyph]["heal"]
		elif spell_effects[die.current_glyph].has("defend"):
			if translated_spell.has("defend"):
				translated_spell["defend"] += spell_effects[die.current_glyph]["defend"]
			else:
				translated_spell["defend"] = spell_effects[die.current_glyph]["defend"]
		elif spell_effects[die.current_glyph].has("echo"):
			if translated_spell.has("echo"):
				translated_spell["echo"] += spell_effects[die.current_glyph]["echo"]
			else:
				translated_spell["echo"] = spell_effects[die.current_glyph]["echo"]
	return translated_spell
