extends StaticBody

enum COLOR { black = 0, red = 1, yellow = 2, orange = 3, blue = 4, purple = 5, green = 6, white = 7}
export(COLOR) var colour = COLOR.red

var distance:float = 0

onready var mesh: MeshInstance = get_child(0)
onready var collider: CollisionShape = get_child(1)
onready var shader:Shader = load("res://resources/light up.shader")
var mat: ShaderMaterial

func _ready():
	add_to_group("light up")
	
	mat = ShaderMaterial.new()
	mat.shader = shader
	match colour:
		0:
			mat.set_shader_param("color", Color(0, 0, 0, 1))
		1:
			mat.set_shader_param("color", Color(1, 0, 0, 1))
		2:
			mat.set_shader_param("color", Color(0, 1, 0, 1))
		3:
			mat.set_shader_param("color", Color(1, 1, 0, 1))
		4:
			mat.set_shader_param("color", Color(0, 0, 1, 1))
		5:
			mat.set_shader_param("color", Color(1, 0, 1, 1))
		6:
			mat.set_shader_param("color", Color(0, 1, 1, 1))
		7:
			mat.set_shader_param("color", Color(1, 1, 1, 1))
	mat.set_shader_param("dist", distance)

	mesh.material_override = mat
	set_active(false)



func update_point(p:Vector3):
	mat.set_shader_param("point", p)

func light_color(n: int, new_distance: float = 10):
	if n & colour != 0:
		set_active(true)
		if distance < new_distance:
			distance = new_distance
			mat.set_shader_param("dist", distance)


func unlight_color(n: int):
	if n & colour != 0:
		set_active(false)
		distance = 0
		mat.set_shader_param("dist", distance)

func set_active(b: bool):
	collider.disabled = !b
	mesh.visible = b
