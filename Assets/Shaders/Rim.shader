Shader "Holistic/Rim"
{
    Properties
    {
        _RimColor("Rim Color", Color) = (0, 0.5, 0.5, 0)
        _RimPower("Rim Power", Range(0.5, 8.0)) = 3.0
    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf Standard fullforwardshadows

            #pragma target 3.0

            struct Input
            {
                float3 viewDir;
                float3 worldPos;
            };

            float4 _RimColor;
            float _RimPower;

            void surf (Input IN, inout SurfaceOutputStandard o)
            {
                // always normalize vectors to produce dot product ranging from [1, -1]
                half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
                o.Emission = frac(IN.worldPos.y * 10 * 0.5) > 0.4 ?
                             float3(0, 1, 0) * rim:
                             float3(1, 0, 0) * rim;
            }
        ENDCG
    }
    FallBack "Diffuse"
}
