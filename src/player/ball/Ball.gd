extends RigidBody

onready var deadtimer := $DeadTimer
onready var droptimer := $DropTimer

export var speed := 40

func _ready():
	set_as_toplevel(true)
	apply_impulse(transform.basis.z, -transform.basis.z * speed)
	deadtimer.start()
	droptimer.start()

func _on_DeadTimer_timeout():
	queue_free()

func _on_DropTimer_timeout():
	gravity_scale = 1.0
