extends PanelContainer
class_name EffectTooltip


@onready var effect_icon: TextureRect = $tooltip_margins/tooltip_info/title/effect_icon
@onready var effect_title: Label = $tooltip_margins/tooltip_info/title/effect_title
@onready var description: Label = $tooltip_margins/tooltip_info/description

var effect:String



func _ready() -> void:
	setup(effect)

func setup(effect_name):
	print("effect tooltip generation", get_children(true))
	if StatusManager.effects_list.keys().has(effect_name):
		effect_icon.texture = StatusManager.condition_icons[effect_name]
		effect_title.text = StatusManager.status_descriptions[effect_name]["title"]
		description.text = StatusManager.status_descriptions[effect_name]["description"]
