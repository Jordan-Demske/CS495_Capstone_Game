shader_type canvas_item;

uniform float frequency = 60;
uniform float depth = 0.005;
uniform float offset = 1f;

void fragment() {
	vec4 green_channel = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 red_channel = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x + (offset * SCREEN_PIXEL_SIZE.x), SCREEN_UV.y));
	vec4 blue_channel = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x - (offset * SCREEN_PIXEL_SIZE.x), SCREEN_UV.y));
	COLOR = vec4(red_channel.r, green_channel.g, blue_channel.b, 1f);
	
	vec2 uv = SCREEN_UV;
	uv.x += sin(uv.y * frequency + TIME) * depth;
	uv.x = clamp(uv.x, 0.0, 1.0);
	vec3 c = textureLod(SCREEN_TEXTURE, uv, 0.0).rgb;
	COLOR.rgb = c;
}