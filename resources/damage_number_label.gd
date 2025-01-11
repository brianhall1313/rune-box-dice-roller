extends Label

func display(damage:Damage) -> void:
	modulate = Color("white",0.0)
	text = str(damage.damage)
	play()

func play() -> void:
	var tween = create_tween()
	tween.tween_property(self,"modulate",Color("white",1.0),.2)
	await get_tree().create_timer(1.0).timeout
	tween = create_tween()
	tween.tween_property(self,"modulate",Color("white",0.0),1)
	await tween.finished
	queue_free()
