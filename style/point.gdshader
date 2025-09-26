shader_type canvas_item;
render_mode blend_mix;

uniform float radius = 80.0;

void fragment() {
    vec4 color1 = vec4(0.47, 0.58, 0.71, 1.0); // #7794b6
    vec4 color2 = vec4(0.87, 0.98, 1.0, 1.0);  // #dffaff

    float gradient = (UV.x + (1.0 - UV.y)) / 2.0;
    vec4 final_color = mix(color1, color2, gradient);

    // ขอบมน: ตัดมุมด้วย circle alpha
    vec2 size = vec2(1.0, 1.0);
    vec2 pixel_pos = UV * size;
    float r = radius / 256.0; // สมมุติขนาด TextEdit ≈ 256x256 (ปรับตามจริง)
    float alpha = 1.0;

    // Check each corner
    if (UV.x < r && UV.y < r) {
        if (distance(UV, vec2(r, r)) > r) alpha = 0.0;
    }
    if (UV.x > 1.0 - r && UV.y < r) {
        if (distance(UV, vec2(1.0 - r, r)) > r) alpha = 0.0;
    }
    if (UV.x < r && UV.y > 1.0 - r) {
        if (distance(UV, vec2(r, 1.0 - r)) > r) alpha = 0.0;
    }
    if (UV.x > 1.0 - r && UV.y > 1.0 - r) {
        if (distance(UV, vec2(1.0 - r, 1.0 - r)) > r) alpha = 0.0;
    }

    COLOR = final_color * alpha;
}
