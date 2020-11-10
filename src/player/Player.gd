extends KinematicBody

onready var head := $Head
onready var ground_check := $GroundCheck

var mouse_sensitivity = 0.03

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
