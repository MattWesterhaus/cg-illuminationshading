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
    gl_Position = projection_matrix * view_matrix * model_matrix * vec4(vertex_position, 1.0);
    vec3 n = normalize(mat3(transpose(inverse(model_matrix))) * vertex_normal);

    for(int i = 0; i<100; i++){
        vec3 l = normalize((light_position[i] - vertex_position));
        vec3 v = (camera_position - vertex_position);
        float product = max(0.0, dot(vertex_normal, l));
        vec3 reflection = reflect(l, vertex_normal);
        float specular_product = max(0.0,dot(reflection, v));

        ambient = light_ambient ;
        diffuse = light_position * light_color * product;
        specular = light_position * pow(specular_product, material_shininess);
    }
}


