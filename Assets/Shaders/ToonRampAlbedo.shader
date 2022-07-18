Shader "Holistic/ToonRampAlbedo"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _RampTex ("Ramp Texture", 2D) = "white" {}
    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf ToonRamp
            #pragma target 3.0

            float4 _Color;
            sampler2D _RampTex;

            float4 LightingToonRamp (SurfaceOutput surface, fixed3 lightDir, fixed atten)
            {
                float diffuse = dot(surface.Normal, lightDir);
                float h = diffuse * 0.5 + 0.5;
                float2 rh = h;
                float3 ramp = tex2D(_RampTex, rh).rgb;

                float4 color;
                color.rgb = surface.Albedo * _LightColor0.rgb * ramp;
                color.a = surface.Alpha;
                return color;
            }

            struct Input
            {
                float2 uv_MainTex;
                float3 viewDir;
            };

            void surf (Input IN, inout SurfaceOutput o)
            {
                float diffuse = dot(o.Normal, IN.viewDir);
                float h = diffuse * 0.5 + 0.5;
                float2 rh = h;
                o.Albedo = tex2D(_RampTex, rh).rgb;
            }
        ENDCG
    }
    FallBack "Diffuse"
}
