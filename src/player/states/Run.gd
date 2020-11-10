extends State

func enter(msg: Dictionary = {}) -> void:
	pass

func unhandled_input(event):
	_parent.unhandled_input(event)

func physics_process(delta):
	_parent.physics_process(delta)
