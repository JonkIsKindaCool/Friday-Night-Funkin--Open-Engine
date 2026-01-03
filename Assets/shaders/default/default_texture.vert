#version 330 core
layout (location = 0) in vec2 aPos;
layout (location = 1) in vec2 aCoord;

uniform mat4 view;
uniform mat4 model;
out vec2 iCoord;

void main(){
    gl_Position = view * model * vec4(aPos, 10, 1);
    iCoord = aCoord;
}