Shader "Holistic/Hologram"
{
    Properties
    {
        _RimColor("Rim Color", Color) = (0, 0.5, 0.5, 0)
        _RimPower("Rim Power", Range(0.5, 8.0)) = 3.0
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }

        Pass
        {
            ZWrite On // saves depth data on first pass into ZBuffer
            ColorMask 0 // does not write any color pixels into FrameBuffer
        }
        
        CGPROGRAM
            #pragma surface surf Standard fullforwardshadows alpha:fade
            #pragma target 3.0

            float4 _RimColor;
            float _RimPower;

            struct Input
            {
                float3 viewDir;
            };

            void surf (Input IN, inout SurfaceOutputStandard o)
            {
                half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
                o.Emission = _RimColor.rgb * pow(rim, _RimPower) * 10;
                o.Alpha = pow(rim, _RimPower);
            }
        ENDCG
    }
    FallBack "Diffuse"
}
