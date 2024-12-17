extends VBoxContainer

@onready var slot_label: Label = $slot_label
@onready var selected_bit: Label = $HBoxContainer/selected_bit

@export var slot:String = ""
@export var selected_index:int = 0

signal decrement
signal increment

func _ready() -> void:
	slot_label.text = slot
	update(0)
	
func update(index) -> void:
	selected_bit.text = str(index+1) + " / " + str(len(Global.player_customization[slot]))


func _on_decrement_button_up() -> void:
	decrement.emit()


func _on_increment_button_up() -> void:
	increment.emit()
