Shader "Holistic/DotProduct"
{
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

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            half dotp = dot(IN.viewDir, o.Normal);
            // half dotp = 1 - dot(IN.viewDir, o.Normal);
            o.Albedo = float3(dotp, 1, 1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
