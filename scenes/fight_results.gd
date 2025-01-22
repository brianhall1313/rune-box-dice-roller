extends PanelContainer

@onready var title: Label = $VBoxContainer/title
@onready var rewards: Label = $VBoxContainer/rewards
@onready var return_to_map: Button = $"VBoxContainer/return to map"
@onready var quit: Button = $VBoxContainer/quit

signal return_to_map_pressed

func _ready() -> void:
	hide()
	#so it can fade in later
	modulate = Color("WHITE",0)

func ending(win:bool,player_rewards:Dictionary) -> void:
	setup(win,player_rewards)
	show()
	return_to_map.disabled = true
	quit.disabled = true
	var tween = create_tween()
	tween.tween_property(self,"modulate",Color("WHITE",1),1.5)
	await tween.finished
	return_to_map.disabled = false
	quit.disabled = false

func setup(win:bool,player_rewards:Dictionary={}) -> void:
	if win:
		title.text = "You Won The Battle!"
		quit.hide()
		rewards.text = "Rewards: \n"
		for i in player_rewards.keys():
			rewards.text += i + " : " + player_rewards[i]+ "\n"
	else:
		return_to_map.text = "retry"
		title.text = "You Died!"
		rewards.text = ""
		quit.show()


func _on_quit_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_return_to_map_button_up() -> void:
	return_to_map_pressed.emit()
