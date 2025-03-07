extends Node

@onready var pause: State = $Pause
@onready var player_turn: State = $player_turn
@onready var enemy_turn: State = $enemy_turn
@onready var animation_playing: Node = $animation_playing
@onready var end: Node = $end


@onready var states:Dictionary={
	"pause":pause,
	"player_turn":player_turn,
	"enemy_turn":enemy_turn,
	"animation_playing":animation_playing,
	"end":end
	}

@onready var current_state: State
var state_stack: Array[State] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_to_global_signal_bus()


func connect_to_global_signal_bus()->void:
	GlobalSignalBus.connect("state_change",state_change)
	GlobalSignalBus.connect("revert_state",revert_state)


func state_change(new_state:String)->void:
	if current_state == end:
		return
	if new_state in states.keys():
		if current_state == states[new_state]:
			#print("Error: state changing to itself ",current_state)
			return
		print("changing state to ",new_state)
		#perform cleanup
		if current_state != null:
			current_state.exit()
		#change state
		state_stack.append(states[new_state])
		current_state = state_stack[len(state_stack)-1]
		Global.current_state=new_state
		#perform any changes need doing
		current_state.enter()
		#print_state_stack()


func revert_state()->void:
	if current_state == end:
		return
	if len(state_stack) <= 1:
		print("Error: no previous state")
		return
	else:
		current_state.exit()
		state_stack.pop_back()
		current_state = state_stack[len(state_stack)-1]
		current_state.enter()
		Global.current_state = current_state.name
		print("changed state to ",current_state.name)
		#print_state_stack()

func print_state_stack()->void:
	print("the current stack")
	for state in state_stack:
		print(state.name)


func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)
