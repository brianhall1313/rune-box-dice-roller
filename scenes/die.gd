extends Control


func _ready() -> void:
	setup("nature","fire")

var glyph_list:Dictionary = {
	"nature":{
		"":preload("res://textures/Nature_Die.png"),
		"fire":preload("res://textures/Fire_Glyph.png"),
		"water":preload("res://textures/Water_Glyph.png"),
		"earth":preload("res://textures/Earth_Glyph.png"),
		"sky":preload("res://textures/Sky_Glyph.png"),
		"life":preload("res://textures/Life_Glyph.png")
		},
	"craft":{
		"":preload("res://textures/Craft_Die.png"),
		"lob":preload("res://textures/Lob_Glyph.png"),
		"temper":preload("res://textures/Temper_Glyph.png")
	},
	"arcane":{
		"":preload("res://textures/Arcane_Die.png"),
		"echo":preload("res://textures/Echo_Glyph.png"),
		"reflect":preload("res://textures/Reflect_Glyph.png")
	}
}

var die_type:String="nature"
var glyph:String=""

func setup(new_type:String,new_glyph:String)->void:
	die_type = new_type
	glyph = new_glyph
	self.texture = glyph_list[die_type][glyph]


func _gui_input(event: InputEvent) -> void:
	if event.is_action_released("click"):
		print("you clicked me D:")
		GlobalSignalBus.rune_interaction.emit(self)
