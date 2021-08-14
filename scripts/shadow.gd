extends RayCast

export var height_ratio: float = .2
onready var mesh = $shadow_mesh
onready var offset = mesh.transform.origin.y

func _process(_delta):
	if is_colliding():
		var point = get_collision_point()
		mesh.global_transform.origin.y = point.y + 0.001

		var size = 1 / (-offset + point.distance_to(global_transform.origin) * height_ratio)
		size = clamp(abs(size), 0, 1)
		mesh.scale.x = size
		mesh.scale.z = size
		mesh.visible = true
	else:
		mesh.visible = false
