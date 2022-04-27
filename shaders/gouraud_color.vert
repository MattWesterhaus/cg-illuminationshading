#version 300 es

precision highp float;

in vec3 vertex_position;
in vec3 vertex_normal;

uniform vec3 light_ambient;
uniform vec3 light_position;
uniform vec3 light_color;
uniform vec3 camera_position;
uniform float material_shininess; // n
uniform mat4 model_matrix;
uniform mat4 view_matrix;
uniform mat4 projection_matrix;

out vec3 ambient;
out vec3 diffuse;
out vec3 specular;

void main() {
    vec3 l = (light_position - vertex_position);
    vec3 v = (camera_position - vertex_position);
    float product = dot(vertex_normal, l);
    vec3 reflection = reflect(l, vertex_normal);
    float specular_product = dot(reflection, v);

    gl_Position = projection_matrix * view_matrix * model_matrix * vec4(vertex_position, 1.0);
    ambient = light_ambient;
    diffuse = light_position * product;
    specular = light_position * pow(specular_product, material_shininess);

}
