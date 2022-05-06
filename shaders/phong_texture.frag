#version 300 es

precision mediump float;

in vec3 frag_pos;
in vec3 frag_normal;
in vec2 frag_texcoord;

uniform vec3 light_ambient;
uniform vec3 light_position;
uniform vec3 light_color;
uniform vec3 camera_position;
uniform vec3 material_color;      // Ka and Kd
uniform vec3 material_specular;   // Ks
uniform float material_shininess; // n
uniform sampler2D image;          // use in conjunction with Ka and Kd

out vec4 FragColor;

void main() {
    vec3 l = normalize(light_position - frag_pos);
    vec3 v = normalize(camera_position - frag_pos);
    float product = max(dot(frag_normal, l), 0.0);
    vec3 diffuse = light_color * product;

    vec3 reflection = reflect(-l, frag_normal);
    float specular_product = max(dot(reflection, v), 0.0);
    vec3 specular = light_color * pow(specular_product, material_shininess);

    FragColor = vec4((light_ambient*material_color + diffuse*material_color + specular*material_specular),  1.0);
    FragColor *= texture(image, frag_texcoord);
}
