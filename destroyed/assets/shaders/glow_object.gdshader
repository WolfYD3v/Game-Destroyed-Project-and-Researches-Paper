shader_type spatial;

uniform vec4 albedo_color : source_color = vec4(1.0);
uniform float metallic : hint_range(0.0, 1.0) = 1.0;
uniform float roughness : hint_range(0.0, 1.0) = 0.1;
uniform vec4 emission_color : source_color = vec4(0.0);
uniform float emission_intensity : hint_range(0.0, 20.0) = 0.0;

void fragment() {
    ALBEDO = albedo_color.rgb;
    METALLIC = metallic;
    ROUGHNESS = roughness;
    EMISSION = emission_color.rgb * emission_intensity;
}
