extends Spatial

enum COLOR { black = 0, red = 1, yellow = 2, orange = 3, blue = 4, purple = 5, green = 6, white = 7}
export(COLOR) var default_colour = COLOR.red

func light_lamp(n: int):
	get_tree().call_group("light up", "light_color", n)


func _process(_delta):
	# set red lit by default
	light_lamp(default_colour)