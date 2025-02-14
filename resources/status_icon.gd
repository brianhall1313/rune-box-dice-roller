extends TextureRect

@onready var amount: Label = $amount

func _ready() -> void:
	setup(StatusManager.POISON,10)

func setup(status:String,val:int) -> void:
	tooltip_text = status
	if status in StatusManager.condition_icons.keys():
		texture = StatusManager.condition_icons[status]
	else:
		texture = Global.error_icon
	amount.text = str(val)
	size = Vector2(16,16)
	expand_mode = EXPAND_FIT_WIDTH
	stretch_mode = STRETCH_KEEP_ASPECT


func _make_custom_tooltip(for_text: String) -> Object:
	print(for_text, " is the for text")
	var effect_tooltip = preload("res://resources/tooltip.tscn").instantiate()
	effect_tooltip.effect = for_text
	return effect_tooltip
