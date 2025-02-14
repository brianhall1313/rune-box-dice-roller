extends MarginContainer

@onready var die_icon: TextureRect = $tooltip/HBoxContainer/die
@onready var die_title: Label = $tooltip/HBoxContainer/die_title
@onready var die_description: Label = $tooltip/die_description

var type:String
var glyph:String

func _ready() -> void:
	setup()


func setup() ->  void:
	var d = DiceDirectory.dir[type][glyph]
	die_icon.texture = d["icon"]
	die_title.text = d["name"]
	die_description.text = d["description"]
