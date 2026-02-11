#version 450
precision mediump float;

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float time;
    vec2 resolution;
} ubuf;

void main()
{
    vec2 uv = vec2(qt_TexCoord0.x, 1.0 - qt_TexCoord0.y);
    vec2 fragCoord = uv * ubuf.resolution.xy;
    vec2 r = ubuf.resolution.xy;
    vec2 p = (fragCoord.xy * 2.0 - r) / r.y;

    float side = p.x - p.y;
    float d = max(abs(side), 0.001) * sign(side);

    float curve = length(p) - 0.4 + 0.01 / d;

    float thickness = 0.015;
    float blueThickness = 0.035;

    float blueMask = smoothstep(-0.02, 0.5, -side);
    float localThickness = mix(thickness, blueThickness, blueMask);

    float o = 0.125 / (abs(curve) + localThickness);
    o = pow(o, mix(1.0, 0.8, blueMask));

    vec3 colTopLeft     = vec3(0.882, 0.443, 0.0);
    vec3 colBottomRight = vec3(0.082, 0.365, 0.988);
    vec3 colSeam        = vec3(0.498, 0.133, 0.996);

    float s = smoothstep(-0.25, 0.25, side);
    vec3 baseCol = mix(colBottomRight, colTopLeft, s);

    baseCol *= 0.75;
    baseCol += 0.05 * sin(vec3(2.0) + ubuf.time);

    float merge = exp(-abs(side + 0.05 * sin(ubuf.time)) * 4.0);

    vec3 col = baseCol * o;
    col = mix(col, colSeam * o, merge);
    col += colSeam * merge * 0.25;

    fragColor = vec4(col, 1.0);
}
