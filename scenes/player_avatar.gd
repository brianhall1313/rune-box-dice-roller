extends TextureRect
@onready var eyes: TextureRect = $eyes
@onready var ears: TextureRect = $ears
@onready var hat: TextureRect = $hat
@onready var outfit: TextureRect = $outfit


func setup(args:Dictionary) -> void:
	self_modulate = Global.colors[args["Body"]]
	eyes.texture = Global.player_customization["Eyes"][0]
	eyes.modulate = Global.colors[args["Eyes"]]
	ears.texture = Global.player_customization["Ears"][args["Ears"]]
	outfit.texture = Global.player_customization["Outfit"][args["Outfit"]]
	hat.texture = Global.player_customization["Hat"][args["Hat"]]
	for child in get_children():
		child.size = size
