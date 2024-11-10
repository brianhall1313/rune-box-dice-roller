extends TextureRect
class_name Die

@onready var selected: Panel = $selected

@onready var glyph_list:Dictionary = {
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

@onready var blank:=preload("res://textures/Die_Divet.png")

var die_type:String="nature"
var current_glyph:String=""
var sides:Array[String] = ["","","","","",""]

var is_selected:bool = false

func _ready() -> void:
	#for testing purposes
	set_selected(is_selected)
	setup("nature",["fire","water","earth","sky","life",""])


func _gui_input(event: InputEvent) -> void:
	if event.is_action_released("click"):
		print("you clicked me D:")
		set_selected(true)
		#for testing purposes
		#roll()
		GlobalSignalBus.rune_interaction.emit(self)

func setup(new_type:String="",new_sides:Array[String]=["","","","","",""])->void:
	if new_type == "":
		self.texture = blank 
		return
	die_type = new_type
	sides = new_sides
	roll()

func get_random() -> String:
	return sides.pick_random()

func report_content() -> Dictionary:
	return {"type":die_type,"current_glyph":current_glyph,"sides":sides}

func roll()->void:
	current_glyph = get_random()
	self.texture = glyph_list[die_type][current_glyph]

func set_selected(value:bool)->void:
	is_selected = value
	selected.visible = is_selected
