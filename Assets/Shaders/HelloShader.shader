Shader "Holistic/HelloShader"
{
    Properties
    {
        _albedoColor("Albedo Color", Color) = (1, 1, 1, 1)
        _emissionColor("Emission Color", Color) = (1, 1, 1, 1)
        _normalColor("Normal Color", Color) = (1, 1, 1, 1)
    }

    SubShader
    {
        CGPROGRAM
            #pragma surface surf Lambert

            struct Input
            {
                float2 uvMainTex;
            };

            fixed4 _albedoColor;
            fixed4 _emissionColor;
            fixed4 _normalColor;

            void surf (Input IN, inout SurfaceOutput o)
            {
                o.Albedo = _albedoColor.rgb;
                o.Emission = _emissionColor.rgb;
                o.Normal = _normalColor.rgb;
            }
        ENDCG
    }

    Fallback "Diffuse"
}