#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

/* Perceptual luminance (Rec.709 / sRGB) */
const vec3 LUMA = vec3(0.2126, 0.7152, 0.0722);

/* Number of grayscale steps */
const float CURVATURE = 0.00;

const float STEPS = 4.0;

void main() {
    vec2 uv = v_texcoord;

    vec2 centered = uv * 2.0 - 1.0;
    centered *= 1.0 + CURVATURE * dot(centered, centered);
    uv = centered * 0.5 + 0.5;
    // Proper border cutoff (prevents edge smear)
    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
        fragColor = vec4(0.0, 0.0, 0.0, 1.0);
        return;
    }
    vec4 color = texture(tex, uv);

    float luminance = dot(color.rgb, LUMA);

    // Quantize to 4 levels
    float quantized = floor(luminance * STEPS) / (STEPS - 1.0);



    fragColor = vec4(vec3(quantized), 1.0);
}
