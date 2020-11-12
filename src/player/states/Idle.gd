extends State

func enter(msg: Dictionary = {}) -> void:
	pass

func unhandled_input(event):
	_parent.unhandled_input(event)

func physics_process(delta):
	if owner.is_on_floor():
		if (_parent.get_move_direction().x != 0.0 or _parent.get_move_direction().z != 0.0):
			_state_machine.transition_to("Move/Run")
	else:
		_state_machine.transition_to("Move/Air")
	_parent.physics_process(delta)
