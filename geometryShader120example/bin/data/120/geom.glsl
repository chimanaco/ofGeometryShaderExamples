#version 120
#extension GL_EXT_geometry_shader4 : enable

#define SPEED 5.0
#define OFFSET 10.0

uniform float time;
uniform mat4 modelViewProjectionMatrix;

varying in vec2 vTexCoord[3];   //[3] because this makes a triangle
varying in vec3 vVertex[3];

void main() {
  vec3 a = vec3(gl_PositionIn[1] - gl_PositionIn[0]);
  vec3 b = vec3(gl_PositionIn[2] - gl_PositionIn[0]);
  vec3 center = vec3(gl_PositionIn[0] + gl_PositionIn[1] + gl_PositionIn[2]) / 3.0;
  vec3 normal = normalize(cross(b, a));

  for(int j = 0; j < gl_VerticesIn; j++) {
    // For Passing Through, use this line
    // gl_Position = gl_PositionIn[j];

    // For modifying geometry a bit, use these three lines
    vec3 newVertex;
    newVertex = normal * cos(time * SPEED + gl_PositionIn[j].xyz) * OFFSET + vVertex[j];
    gl_Position = gl_ProjectionMatrix * vec4(newVertex, 1.0);

    gl_TexCoord[0].st = vTexCoord[j];
    EmitVertex();
  }
  EndPrimitive();
}