shader_type spatial; // Define shader type for 3D

void fragment() {
    // Calculate the coordinates for the checkerboard pattern
    vec2 uv = UV * 4.0; // Multiply UV by 4 to get 4 squares across the texture space
    // Determine the checker pattern by checking the integer part of the UVs
    bool checker = int(mod(uv.x, 2.0)) == int(mod(uv.y, 2.0));
    // Set the color based on the checker pattern
    vec3 color = checker ? vec3(0.0, 0.0, 0.0) : vec3(1.0, 1.0, 1.0);
    // Assign color to ALBEDO
    ALBEDO = color;
}
