shader_type canvas_item;

void fragment() {
    vec4 color1 = vec4(0.47, 0.58, 0.71, 1.0); // #7794b6
    vec4 color2 = vec4(0.87, 0.98, 1.0, 1.0);   // #dffaff

    float gradient = (UV.x + (1.0 - UV.y)) / 2.0;
	
    COLOR = mix(color1, color2, gradient);
}
