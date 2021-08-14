shader_type spatial;

uniform vec4 color: hint_color = vec4(1, 1, 1, 1);
uniform vec3 point;
uniform float dist;

void fragment(){
	vec3 col = color.xyz * ALBEDO;
	vec3 wPos = (CAMERA_MATRIX * vec4(VERTEX, 1)).xyz;
	
	float a = step(distance(point, wPos), dist);
	ALPHA = a;
	ALBEDO = col;
}