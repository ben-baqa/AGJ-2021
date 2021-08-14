extends KinematicBody
# movement fucntionality
export var friction: float = 0.1
export var move_force: float = 10
export var jump_force: float = 10
export var gravity: float = 8
export var turn_ratio: float = 0.3

var velocity: Vector3 = Vector3.ZERO
var forward: Vector2
onready var cam = $Camera_Controller
onready var character_model = $pluggy
onready var shadow = $shadow

func _physics_process(_delta):
	var dir = Vector3.ZERO;
	if Input.is_action_pressed("forward"):
		dir -= cam.transform.basis.z
	if Input.is_action_pressed("backward"):
		dir += cam.transform.basis.z
	if Input.is_action_pressed("right"):
		dir += cam.transform.basis.x
	if Input.is_action_pressed("left"):
		dir -= cam.transform.basis.x
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_force

	if dir != Vector3.ZERO:
		character_model.rotation.y = lerp(character_model.rotation.y, cam.rotation.y, turn_ratio)
		velocity += dir.normalized() * move_force
		

	velocity.y -= gravity
	velocity.x *= (1 - friction)
	velocity.z *= (1 - friction)

	velocity = move_and_slide(velocity, Vector3.UP)
