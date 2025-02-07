extends TextureRect

@onready var amount: Label = $amount

func setup(status:String,val:int) -> void:
	if status in StatusManager.condition_icons.keys():
		texture = StatusManager.condition_icons[status]
	else:
		texture = Global.error_icon
	amount.text = str(val)
	size = Vector2(16,16)
	expand_mode = EXPAND_FIT_WIDTH
	stretch_mode = STRETCH_KEEP_ASPECT
