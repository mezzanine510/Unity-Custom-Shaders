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
            // Physically based Standard lighting model, and enable shadows on all light types
            #pragma surface surf Standard fullforwardshadows

            // Use shader model 3.0 target, to get nicer looking lighting
            #pragma target 3.0

            struct Input
            {
                float3 viewDir;
            };

            float4 _RimColor;
            float _RimPower;

            void surf (Input IN, inout SurfaceOutputStandard o)
            {
                half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal)); // always normalize vectors to produce dot product ranging from [1, -1]
                o.Emission = _RimColor.rgb * pow(rim, _RimPower);
            }
        ENDCG
    }
    FallBack "Diffuse"
}
