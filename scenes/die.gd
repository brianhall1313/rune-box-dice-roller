extends Node2D
@onready var die_face: Sprite2D = $die_face

var glyph_list:Dictionary = {
	"nature":{
		"":preload("res://textures/Nature_Die.png"),
		"fire":"",
		"water":"",
		"earth":"",
		"sky":"",
		"life":""
		},
	"craft":{
		"":preload("res://textures/Craft_Die.png"),
		"lob":"",
		"temper":""
	},
	"arcane":{
		"":preload("res://textures/Arcane_Die.png"),
		"echo":"",
		"reflect":""
	}
}

var die_type:String="nature"
var glyph:String=""

func setup(new_type:String,new_glyph:String)->void:
	die_type = new_type
	glyph = new_glyph
	die_face.texture = glyph_list[die_type][glyph]


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_released("click"):
		GlobalSignalBus.rune_interaction.emit(self)
