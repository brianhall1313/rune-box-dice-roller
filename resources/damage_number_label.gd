extends Label

var element_color:String="white"

func display(damage:Damage) -> void:
	element_color = get_color(damage)
	modulate = Color(element_color,0.0)
	text = str(damage.damage)
	play()

func play() -> void:
	var tween = create_tween()
	tween.tween_property(self,"modulate",Color(element_color,1.0),.2)
	await get_tree().create_timer(1.0).timeout
	tween = create_tween()
	tween.tween_property(self,"modulate",Color(element_color,0.0),1)
	await tween.finished
	queue_free()

func get_color(damage:Damage) -> String:
	match damage.type:
		"fire":
			return "orange"
		"water":
			return "blue"
		"earth":
			return "brown"
		"sky":
			return "yellow"
		"bleed":
			return "red"
		"poison":
			return "green"
		_:
			return "white"
