extends Node

var spell_directory: Dictionary = {
	"fire":{
		"lob":{
			"name":"fire hurl",
			"damage":func ():return Damage.new(10,"fire"),
			"animation":preload("res://resources/spell_animations/fire_lob.tscn")
		},
		"temper":{
			"name":"fire wall",
			"defend":10,
			"animation":preload("res://resources/spell_animations/fire_temper.tscn")
			},
		"reflect":{
			"name":"fire back",
			"effect":{"reflect fire":1}
			}
	},
	"earth":{
		"lob":{
			"name":"rock huck",
			"damage":func ():return Damage.new(10,"earth"),
			"animation":preload("res://resources/spell_animations/earth_lob.tscn")
		},
		"temper":{
			"name":"stone wall",
			"defend":10,
			"animation":preload("res://resources/spell_animations/earth_temper.tscn")
			},
		"reflect":{
			"name":"polished rock",
			"effect":{"reflect earth":1}
			}
		},
	"water":{
		"lob":{
			"name":"wet smack",
			"damage":func ():return Damage.new(10,"water"),
			"animation":preload("res://resources/spell_animations/water_lob.tscn")
		},
		"temper":{
			"name":"tidal wall",
			"defend":10,
			"animation":preload("res://resources/spell_animations/water_temper.tscn")
			},
		"reflect":{
			"name":"mirrored surface",
			"effect":{"reflect water":1}
			}
		},
	"sky":{
		"lob":{
			"name":"sparkles",
			"damage":func ():return Damage.new(10,"sky"),
			"animation":preload("res://resources/spell_animations/sky_lob.tscn")
		},
		"temper":{
			"name":"winderwall",
			"defend":10,
			"animation":preload("res://resources/spell_animations/sky_temper.tscn")
			},
		"reflect":{
			"name":"blowback",
			"effect":{"reflect sky":1}
			}
		},
	"life":{
		"lob":{
			"name":"blood smack",
			"damage":func ():return Damage.new(10,"life"),
			"animation":preload("res://resources/spell_animations/life_lob.tscn")
		},
		"temper":{
			"name":"heals~",
			"heal":10,
			"animation":preload("res://resources/spell_animations/life_temper.tscn")
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
	if is_spell(spell):
		return spell_directory[spell[0].current_glyph][spell[1].current_glyph]
	return {}
