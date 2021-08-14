extends Spatial

export var elastic_force: float = 0.1
export var parent_speed_ratio: float = .1
export var eye_turn_speed: float = 0.2
export var friction: float = 0.1

onready var parent: Spatial = get_node("..")
onready var prev_parent_pos: Vector3 = get_node("..").global_transform.origin

onready var cam: Spatial = get_node("../Camera_Controller")
onready var offset: Vector3 = transform.origin

var vel: Vector3 = Vector3.ZERO


# func _ready():
# 	for i in range(0, delay_steps):
# 		prev_pos.append(global_transform.origin)
# 		prev_rot.append(0)

func _physics_process(_delta):
	rotation.y = lerp(rotation.y, cam.rotation.y, eye_turn_speed)

	var p = parent.global_transform.origin

	vel -= (p - prev_parent_pos) * parent_speed_ratio
	vel += (offset - transform.origin) * elastic_force
	vel *= (1 - friction)

	transform.origin += vel
	prev_parent_pos = p
