extends Node
@onready var pause: Node = $pause


@onready var states:Dictionary={
	"pause":pause
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
	if new_state in states.keys():
		if current_state == states[new_state]:
			print("Error: state changing to itself ",current_state)
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
		print_state_stack()


func revert_state()->void:
	if len(state_stack) <= 1:
		print("Error: no previous state")
		return
	else:
		current_state.exit()
		state_stack.pop_back()
		current_state = state_stack[len(state_stack)-1]
		current_state.enter()
		Global.current_staten = current_state.name
		print("changed state to ",current_state.name)
		print_state_stack()

func print_state_stack()->void:
	print("the current stack")
	for state in state_stack:
		print(state.name)


func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)
