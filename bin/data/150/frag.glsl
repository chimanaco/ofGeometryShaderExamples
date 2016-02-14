#version 150

uniform sampler2DRect tex0;

in vec2 vTexCoord;
out vec4 Out_Color;

void main() {
    Out_Color = texture(tex0, vTexCoord);
}