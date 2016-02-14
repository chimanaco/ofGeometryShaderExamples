#version 150

#define SPEED 5.0
#define OFFSET 10.0

layout(triangles) in;
layout(triangle_strip) out;
layout(max_vertices = 3) out;

uniform float time;
uniform mat4 modelViewProjectionMatrix;

in Vertex {
  vec4 normal;
  vec4 color;
  vec2 texCoord;
} vertex[];
 
out vec2 vTexCoord;

void main() {
  vec3 a = vec3(gl_in[1].gl_Position - gl_in[0].gl_Position);
  vec3 b = vec3(gl_in[2].gl_Position - gl_in[0].gl_Position);
  vec3 center = vec3(gl_in[0].gl_Position + gl_in[1].gl_Position + gl_in[2].gl_Position) / 3.0;
  vec3 normal = normalize(cross(b, a));

  for(int j = 0; j < gl_in.length(); j++) {
    // For Passing Through, use this line
    // gl_Position = modelViewProjectionMatrix * gl_in[j].gl_Position;

    // For modifying geometry a bit, use these three lines
    vec3 newVertex;
    newVertex = normal * cos(time * SPEED + gl_in[j].gl_Position.x) * OFFSET + vec3(gl_in[j].gl_Position.xyz);
    gl_Position = modelViewProjectionMatrix * vec4(newVertex, 1.0);

    vTexCoord = vertex[j].texCoord;
    EmitVertex();
  }
  EndPrimitive();
}