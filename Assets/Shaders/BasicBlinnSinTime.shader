Shader "Holistic/BasicBlinnSinTime"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags 
        {
            "Queue"="Geometry"
        }

        CGPROGRAM
            #pragma surface surf BasicBlinnSinTime
            #pragma target 3.0

            float4 _Color;

            half4 LightingBasicBlinnSinTime (SurfaceOutput surface, half3 lightDir, half3 viewDir, half atten)
            {
                // blinn-phong method starts by using the half-way vector between the light and view directions
                half3 halfway = normalize(lightDir + viewDir);
                half diffuse = max(0, dot(surface.Normal, lightDir));

                float specFalloff = max(0, dot(surface.Normal, halfway)); // specular intensity falloff
                float spec = pow(specFalloff, 48.0); // 48.0 is Unity's default

                half4 color;
                color.rgb = (surface.Albedo * _LightColor0.rgb * diffuse + _LightColor0.rgb * spec) * atten * _SinTime;
                color.a = surface.Alpha;
                return color;
            }

            struct Input
            {
                float2 uv_MainTex;
            };

            void surf (Input IN, inout SurfaceOutput o)
            {
                o.Albedo = _Color.rgb;
            }
        ENDCG
    }
    FallBack "Diffuse"
}
