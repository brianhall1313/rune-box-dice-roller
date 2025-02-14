extends VBoxContainer

@onready var type_icon: TextureRect = $dice_summary/type_icon
@onready var glyph_title: Label = $dice_summary/glyph_title
@onready var glyph_container: HBoxContainer = $full_dice_view/glyph_container

var source_index

signal delete(index:int)

func setup(dice:Dictionary,index:int) -> void:
	source_index = index
	type_icon.texture = Global.glyph_list[dice["type"]][""]
	glyph_title.text = dice["name"]
	var list:Array = glyph_container.get_children()
	var i = 0
	for item in list:
		item.texture = Global.glyph_list[dice["type"]][dice["faces"][i]]
		i += 1


func _on_delete_button_button_up() -> void:
	delete.emit(source_index)
