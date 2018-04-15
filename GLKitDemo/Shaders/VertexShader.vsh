attribute vec4 a_Position;
attribute vec4 a_Color;
attribute vec2 a_TexCoord;

varying lowp vec4 frag_Color;
varying lowp vec2 frag_TexCoord;

void main(void) {
    frag_Color = a_Color;
    frag_TexCoord = a_TexCoord;
    gl_Position = a_Position;
}
