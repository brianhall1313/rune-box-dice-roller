extends Node

@onready var glyph_list:Dictionary = {
	"nature":{
		"":preload("res://textures/Nature_blank.png"),
		"fire":preload("res://textures/Fire_Glyph.png"),
		"water":preload("res://textures/Water_Glyph.png"),
		"earth":preload("res://textures/Earth_Glyph.png"),
		"sky":preload("res://textures/Sky_Glyph.png"),
		"life":preload("res://textures/Life_Glyph.png")
		},
	"craft":{
		"":preload("res://textures/Craft_Blank.png"),
		"lob":preload("res://textures/Lob_Glyph.png"),
		"temper":preload("res://textures/Temper_Glyph.png")
	},
	"arcane":{
		"":preload("res://textures/Arcane_Blank.png"),
		"echo":preload("res://textures/Echo_Glyph.png"),
		"reflect":preload("res://textures/Reflect_Glyph.png")
	}
}

@onready var player_customization: Dictionary = {
	"Body":[
		preload("res://textures/character/char base_1.png"),
		],
	"Ears":[
		null,
		preload("res://textures/character/char base_floppy_ears.png"),
		preload("res://textures/character/char base_pointy_ears.png")
		],
	"Outfit":[
		null,
		preload("res://textures/character/char base_mantle.png"),
		preload("res://textures/character/char base_sage_hood.png"),
		],
		"Hat":[
			null,
			preload("res://textures/character/char base_scarf.png"),
			preload("res://textures/character/char base_witch_hat.png")
		]
	
}

@onready var damage = preload("res://resources/damage.gd")

var current_state:String = "none"
