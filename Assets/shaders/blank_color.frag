#version 330 core
uniform vec4 u_Color;
uniform sampler2D tex;

in vec2 txCoord;

void main() {
    gl_FragColor = texture2D(tex, txCoord);
}
