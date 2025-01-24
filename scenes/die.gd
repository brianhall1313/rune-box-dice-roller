extends TextureRect
class_name Die

@onready var selected: Panel = $selected

@onready var blank:=preload("res://textures/Die_Divet.png")

var die_type:String="nature"
var current_glyph:String=""
var faces:Array = ["","","","","",""]
var die_name:String = ''

var adjacent:Dictionary = {"up":null,"down":null,"right":null,"left":null,}
var pos:Dictionary = {}
var is_selected:bool = false

func _ready() -> void:
	set_selected(is_selected)
	#for testing purposes
	setup("Elemental","nature",["fire","water","earth","sky","life",""])


func _gui_input(event: InputEvent) -> void:
	if event.is_action_released("click"):
		#for testing purposes
		#roll()
		GlobalSignalBus.emit_rune_interaction(self)

func setup(new_name:String="",new_type:String="",new_faces:Array=["","","","","",""])->void:
	if new_type == "":
		self.texture = blank 
		return
	die_type = new_type
	faces = new_faces
	die_name = new_name
	roll()

func set_blank() -> void:
	setup("","")

func get_random() -> String:
	return faces.pick_random()

func report_content() -> Dictionary:
	return {"type":die_type,"current_glyph":current_glyph,"faces":faces}

func roll()->void:
	current_glyph = get_random()
	self.texture = Global.glyph_list[die_type][current_glyph]
	_make_custom_tooltip('')

func _make_custom_tooltip(_for_text: String) -> Object:
	var label = Label.new()
	if current_glyph != "":
		label.text = die_type +" die on "+ current_glyph
	else:
		label.text = die_type +" die"
	return label

func set_selected(value:bool)->void:
	is_selected = value
	selected.visible = is_selected

func set_adjacent(new:Dictionary)->void:
	adjacent = new

func set_pos(new_pos:Dictionary)->void:
	pos=new_pos
