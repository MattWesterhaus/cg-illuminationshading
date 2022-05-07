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
    //for(int i = 0; i < 10; i++){
        vec3 world = vec3(model_matrix * vec4(vertex_position,1.0));
        vec3 l = normalize(light_position - world);
        vec3 v = normalize(camera_position - world);
        vec3 normal = normalize(mat3(transpose(inverse(model_matrix))) * vertex_normal);
        float product = max(dot(normal, l), 0.0);
        vec3 reflection = reflect(-l, normal);
        float specular_product = max(dot(reflection, v), 0.0);
        
        ambient = light_ambient;
        diffuse = light_color * product;
        specular = light_color * pow(specular_product, material_shininess);
        gl_Position = projection_matrix * view_matrix * model_matrix * vec4(vertex_position, 1.0);
    //}
}

