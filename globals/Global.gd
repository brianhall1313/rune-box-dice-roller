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
