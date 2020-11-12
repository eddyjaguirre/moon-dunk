extends State

export var acceleration := 1

func enter(msg: Dictionary = {}) -> void:
	_parent.current_accel = acceleration
	if "jump_strength" in msg:
		_parent.gravity_vector = Vector3.UP * msg.jump_strength

func exit():
	_parent.current_accel = _parent.horizontal_accel

func unhandled_input(event):
	_parent.unhandled_input(event)

func physics_process(delta):
	_parent.physics_process(delta)
	if owner.is_on_floor():
		_state_machine.transition_to("Move/Idle")
