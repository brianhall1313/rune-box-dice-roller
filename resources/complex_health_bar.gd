extends ProgressBar

@onready var health_bar: ProgressBar = $"health_bar"

var animation_speed:float = 0.5
var heal_color:Color = Color( 0, 250,0,255)
var damage_color:Color = Color(255,0,0,255)



func setup(current:int,total:int)-> void:
	health_bar.value = current
	health_bar.max_value = total
	value = current
	max_value = total
	#health_bar.size = size

func update(new_val) -> void:
	#print(new_val)
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
