Shader "Holistic/Rim"
{
    Properties
    {
        _DiffuseTexture ("Diffuse Texture", 2D) = "white" {}
        _RimColor("Rim Color", Color) = (0, 0.5, 0.5, 0)
        _RimPower("Rim Power", Range(0.5, 8.0)) = 3.0
        _StripeWidth("Stripe Width", Range(0, 1)) = 0.5
    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf Standard fullforwardshadows

            #pragma target 3.0

            sampler2D _DiffuseTexture;
            float4 _RimColor;
            float _RimPower;
            float _StripeWidth;

            struct Input
            {
                float2 uv_DiffuseTexture;
                float3 viewDir;
                float3 worldPos;
            };

            void surf (Input IN, inout SurfaceOutputStandard o)
            {
                // o.Albedo = _DiffuseTexture.rgb;
                o.Albedo = tex2D(_DiffuseTexture, IN.uv_DiffuseTexture).rgb;

                // always normalize vectors to produce dot product ranging from [1, -1]
                half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
                o.Emission = frac(IN.worldPos.y * 10 * 0.5) > _StripeWidth ?
                             float3(0, 1, 0) * rim :
                             float3(1, 0, 0) * rim;
            }
        ENDCG
    }
    FallBack "Diffuse"
}
