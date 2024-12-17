extends TextureRect

@onready var ears: TextureRect = $ears
@onready var hat: TextureRect = $hat
@onready var outfit: TextureRect = $outfit


func setup(args:Dictionary) -> void:
	texture = Global.player_customization["Body"][args["Body"]]
	ears.texture = Global.player_customization["Ears"][args["Ears"]]
	outfit.texture = Global.player_customization["Outfit"][args["Outfit"]]
	hat.texture = Global.player_customization["Hat"][args["Hat"]]
	for child in get_children():
		child.size = size