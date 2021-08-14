extends Spatial

export var mouse_sensitivity: Vector2 = Vector2(1, 1)

var active: bool = true;
onready var x_rot = $x_rotation
var rot:Vector2 =  Vector2(0, 0)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if active and event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity.x))
		if rotation_degrees.y > 360:
			rotation_degrees.y -= 360
		if rotation_degrees.y < 0:
			rotation_degrees.y += 360

		x_rot.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity.y))
		x_rot.rotation_degrees.x = clamp(x_rot.rotation_degrees.x, -90, 0)
	
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		active = false
	
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			active = true
	
	if event.is_action_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen;
