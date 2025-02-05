extends Control
class_name Monster_UI

@onready var complex_health_bar: ProgressBar = $display/complex_health_bar
@onready var status_conditions: HBoxContainer = $display/status_conditions
@onready var action_icon: TextureRect = $display/action_icon
@onready var body_spacer: Control = $display/body_spacer

@onready var icons = Global.intentions

@onready var status_icon:PackedScene = preload("res://resources/status_icon.tscn")

@onready var parent:Monster = get_parent()

@export var min_y: float

func intention(icon:String) -> void:
	if icon in icons.keys():
		action_icon.texture = icons[icon] 
	else:
		action_icon.texture = Global.error_icon


func clear_intentions() -> void:
	action_icon.texture = null

func setup() -> void:
	body_spacer.custom_minimum_size.y = min_y
	complex_health_bar.setup(parent.health.health,parent.health.max_health)

func update() -> void:
	complex_health_bar.update(parent.health.health)

func show_status() -> void:
	for child in status_conditions.get_children():
		child.queue_free()
	for status in parent.status.keys():
		var new = status_icon.instantiate()
		status_conditions.add_child(new)
		new.setup(status,parent.status[status])
