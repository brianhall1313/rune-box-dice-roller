extends ProgressBar

@onready var health_bar: ProgressBar = $"health_bar"
@onready var health_display: Label = $health_display

var animation_speed:float = 0.5
var heal_color:Color = Color( 0, 250,0,255)
var damage_color:Color = Color(255,0,0,255)



func setup(current:int,total:int)-> void:
	health_bar.value = current
	health_bar.max_value = total
	value = current
	max_value = total
	set_text(value)
	#health_bar.size = size

func update(new_val:int) -> void:
	#print(new_val) 
	set_text(new_val)
	if new_val > value:
		self_modulate = heal_color
		value = new_val
		var tween = create_tween()
		tween.tween_property(health_bar,"value", new_val,animation_speed)
	else:
		self_modulate = damage_color
		health_bar.value = new_val 
		var tween = create_tween()
		tween.tween_property(self,"value", new_val,animation_speed)

func set_text(amount:int) -> void:
	health_display.text = str(amount) + "/" + str(max_value)
