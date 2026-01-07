#version 330 core
layout(location = 0) in vec2 aPos;
layout(location = 1) in vec2 aCoord;

uniform mat4 projection;
uniform mat4 view;

out vec2 iCoord;

void main() {
    gl_Position = projection * view * vec4(aPos, 0, 1);
    iCoord = aCoord;
}