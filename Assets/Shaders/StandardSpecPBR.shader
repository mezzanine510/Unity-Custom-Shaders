Shader "Holistic/StandardSpecPBR"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MetallicTex ("Metallic (R)", 2D) = "white" {}
        _SpecColor ("Specular", Color) = (1,1,1,1) // already exists inside unity include compilation files - no need to declare this within the SubShader
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }

        CGPROGRAM
            #pragma surface surf StandardSpecular fullforwardshadows
            #pragma target 3.0

            sampler2D _MetallicTex;
            fixed4 _Color;

            struct Input
            {
                float2 uv_MetallicTex;
            };

            void surf (Input IN, inout SurfaceOutputStandardSpecular o)
            {
                o.Albedo = _Color.rgb;
                // Metallic and smoothness come from slider variables
                o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).r;
                o.Specular = _SpecColor.rgb;
            }
        ENDCG
    }
    FallBack "Diffuse"
}
