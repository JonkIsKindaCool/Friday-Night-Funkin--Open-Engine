#version 330 core
attribute vec2 aPosition;
attribute vec2 texCoord;

uniform mat4 projection;

out vec2 txCoord;

void main() {
    gl_Position = projection * vec4(aPosition, 0, 1.0);
    txCoord = texCoord;
}
