extends VBoxContainer

@onready var full_dice_view: VBoxContainer = $full_dice_view
@onready var type_icon: TextureRect = $dice_summary/type_icon
@onready var glyph_title: Label = $dice_summary/glyph_title
@onready var count: Label = $dice_summary/count
@onready var glyph_container: HBoxContainer = $full_dice_view/glyph_container


func _gui_input(event: InputEvent) -> void:
	if event.is_action_released("click"):
		full_dice_view.visible = !full_dice_view.visible

func setup(dice:Dictionary) -> void:
	type_icon.texture = Global.glyph_list[dice["type"]][""]
	glyph_title.text = dice["name"]
	count.text = str(dice["count"])
	var list:Array = glyph_container.get_children()
	var i = 0
	for item in list:
		item.texture = Global.glyph_list[dice["type"]][dice["faces"][i]]
		i += 1
