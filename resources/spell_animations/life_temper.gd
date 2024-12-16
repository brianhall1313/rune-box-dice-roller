extends GPUParticles2D


func _on_effect_life_timeout() -> void:
	queue_free()
