extends State

export var speed := 10
export var horizontal_accel := 6.0

export var gravity := 20
export var jump := 10

var current_accel = horizontal_accel
var direction = Vector3()
var horizontal_vel = Vector3()
var gravity_vector = Vector3()

var full_floor_contact = false

func enter(msg: Dictionary = {}) -> void:
	pass

func unhandled_input(event):
	if event is InputEventMouseMotion:
		owner.rotate_y(deg2rad(-event.relative.x * owner.mouse_sensitivity))
		owner.head.rotate_x(deg2rad(-event.relative.y * owner.mouse_sensitivity))
		owner.head.rotation.x = clamp(owner.head.rotation.x, -89, 80)

func physics_process(delta: float) -> void:
	gravity_handler(delta)
	
	if Input.is_action_just_pressed("jump") and (owner.is_on_floor() or full_floor_contact):
		_state_machine.transition_to("Move/Air", {jump_strength = jump})
	
	owner.move_and_slide(handle_movement(delta), Vector3.UP)

func exit() -> void:
	pass

func gravity_handler(delta):
	full_floor_contact = owner.ground_check.is_colliding()
	
	if not owner.is_on_floor():
		gravity_vector += Vector3.DOWN * gravity * delta
	elif owner.is_on_floor() and full_floor_contact:
		gravity_vector = -owner.get_floor_normal() * gravity
	else:
		gravity_vector = -owner.get_floor_normal()

func get_move_direction():
	direction = Vector3()
	if Input.is_action_pressed("move_forward"):
		direction -= owner.transform.basis.z
	elif Input.is_action_pressed("move_backward"):
		direction += owner.transform.basis.z
	
	if Input.is_action_pressed("move_left"):
		direction -= owner.transform.basis.x
	elif Input.is_action_pressed("move_right"):
		direction += owner.transform.basis.x
	
	direction = direction.normalized()
	return direction

func handle_movement(delta):
	var movement = Vector3()
	
	horizontal_vel = horizontal_vel.linear_interpolate(get_move_direction() * speed, current_accel * delta)
	movement.z = horizontal_vel.z + gravity_vector.z
	movement.x = horizontal_vel.x + gravity_vector.z
	movement.y = gravity_vector.y
	
	return movement
