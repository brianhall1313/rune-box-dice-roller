extends Node

var spell_directory: Dictionary = {
	"fire":{
		"lob":{
			"name":"fire hurl",
			"damage":func ():return Damage.new(10,"fire")
		},
		"temper":{
			"name":"fire wall",
			"defend":10
			},
		"reflect":{
			"name":"fire back",
			"effect":{"reflect fire":1}
			}
	},
	"earth":{
		"lob":{
			"name":"rock huck",
			"damage":func ():return Damage.new(10,"earth")
		},
		"temper":{
			"name":"stone wall",
			"defend":10
			},
		"reflect":{
			"name":"polished rock",
			"effect":{"reflect earth":1}
			}
		},
	"water":{
		"lob":{
			"name":"wet smack",
			"damage":func ():return Damage.new(10,"water")
		},
		"temper":{
			"name":"tidal wall",
			"defend":10
			},
		"reflect":{
			"name":"mirrored surface",
			"effect":{"reflect water":1}
			}
		},
	"sky":{
		"lob":{
			"name":"sparkles",
			"damage":func ():return Damage.new(10,"sky")
		},
		"temper":{
			"name":"winderwall",
			"defend":10
			},
		"reflect":{
			"name":"blowback",
			"effect":{"reflect sky":1}
			}
		},
	"life":{
		"lob":{
			"name":"blood smack",
			"damage":func ():return Damage.new(10,"life")
		},
		"temper":{
			"name":"heals~",
			"heal":10
			},
		"reflect":{
			"name":"reflect damage",
			"effect":{"reflect damage":1}
			}
		},
	
}

func is_spell(spell) -> bool:
	if len(spell) >= 2:
		#print("pass 1: ", spell[0].current_glyph,"  ",spell[1].current_glyph)
		if spell_directory.has(spell[0].current_glyph):
			#print("pass 2")
			if spell_directory[spell[0].current_glyph].has(spell[1].current_glyph):
				#print("pass 3")
				return true
	return false

func effect_generation(spell) -> Dictionary:
	return spell_directory[spell[0].current_glyph][spell[1].current_glyph]

func get_ui_info(spell) -> Dictionary:
	if len(spell) >= 2:
		return spell_directory[spell[0].current_glyph][spell[1].current_glyph]
	return {}
