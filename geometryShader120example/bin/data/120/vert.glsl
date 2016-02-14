#version 120

varying vec2 vTexCoord;
varying vec3 vVertex;

void main() {
  gl_FrontColor =  gl_Color;
	gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
	vTexCoord = vec2(gl_TextureMatrix[0]*gl_MultiTexCoord0);
	vVertex = vec3(gl_ModelViewMatrix * gl_Vertex);
}