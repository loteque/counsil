shader_type spatial;  // This defines the shader type as being used for 3D objects.

// Declare a uniform texture which will be your viewport texture.
uniform sampler2D viewport_texture;

void fragment() {
    // Calculate UV coordinates.
    vec2 uv = vec2(UV.x, 1.0 - UV.y);
    // Use the UV coordinates to get the color from the texture.
    vec4 tex_color = texture(viewport_texture, uv);
    // Assign the texture color to ALBEDO which defines the surface color.
    ALBEDO = tex_color.rgb;
    ALPHA = tex_color.a;  // Set the alpha for transparency.
}