extends TextureRect

@onready var amount: Label = $amount

func setup(status:String,val:int) -> void:
	if status in Global.condition_icons.keys():
		texture = Global.condition_icons[status]
	else:
		texture = Global.error_icon
	amount.text = str(val)
