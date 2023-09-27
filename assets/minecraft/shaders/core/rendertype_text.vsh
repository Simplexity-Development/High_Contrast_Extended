#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;
uniform int FogShape;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vertexDistance = fog_distance(ModelViewMat, IViewRotMat * Position, FogShape);
    
    vec4 ColorM = Color; // mutable version of Color uniform
	if (vertexDistance >= 800.0 && ivec3(ColorM.rgb * 255. + 0.5) == ivec3(64, 64, 64)) {
        ColorM = vec4(1.0, 1.0, 1.0, 1.0);
    } else if (vertexDistance >= 800.0 && ivec3(ColorM.rgb * 255. + 0.5) == ivec3(0, 0, 0)) {
        ColorM = vec4(1.0, 1.0, 1.0, 1.0);
    }  else if (vertexDistance >= 800.0 && ivec3(ColorM.rgb * 255. + 0.5) == ivec3(52, 47, 37)) {
        ColorM = vec4(0.0, 0.0, 0.0, 1.0);
    }  else if (vertexDistance >= 800.0 && ivec3(ColorM.rgb * 255. + 0.5) == ivec3(170, 0, 170)) {
        ColorM = vec4(201.0, 100.0, 252.0, 1.0);
    }  else if (vertexDistance >= 800.0 && ivec3(ColorM.rgb * 255. + 0.5) == ivec3(104, 94, 74)) {
        ColorM = vec4(85.0, 252.0, 7.0, 1.0);
    }  else if (vertexDistance >= 800.0 && ivec3(ColorM.rgb * 255. + 0.5) == ivec3(255, 255, 128)) {
        ColorM = vec4(252.0, 206.0, 2.0, 1.0);
    }

    vertexColor = ColorM * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;
}
