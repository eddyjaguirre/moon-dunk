extends KinematicBody

onready var head 			:= $Head
onready var hand 			:= $Head/Hand
onready var handloc 		:= $Head/HandLocation
onready var ground_check 	:= $GroundCheck
onready var aimcast			:= $Head/Camera/AimCast
onready var ball_pos		:= $Head/Hand/Ball
onready var ball			:= preload("res://src/player/Ball.tscn")

export var sway				:= 30

var mouse_sensitivity = 0.03

func _ready():
	hand.set_as_toplevel(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	handle_shoot()
	handle_ball_sway(delta)
	if Input.is_action_just_pressed("pause"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			

func handle_ball_sway(delta):
#	hand.global_transform.origin = handloc.global_transform.origin
	hand.rotation.y = lerp_angle(hand.rotation.y, rotation.y, sway * delta)
	hand.rotation.x = lerp_angle(hand.rotation.x, head.rotation.x, sway * delta)
	hand.global_transform.origin = lerp(
		hand.global_transform.origin,
		handloc.global_transform.origin,
		sway * delta
	)

func handle_shoot():
	if Input.is_action_just_released("shoot"):
		if aimcast.is_colliding():
			var ball_instance = ball.instance()
			ball_pos.look_at(aimcast.get_collision_point(), Vector3.UP)
			ball_pos.add_child(ball_instance)
