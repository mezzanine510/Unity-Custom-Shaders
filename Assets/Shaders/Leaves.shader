Shader "Holistic/Leaves"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }

        CGPROGRAM
            #pragma surface surf Standard fullforwardshadows alpha:fade
            #pragma target 3.0

            sampler2D _MainTex;

            struct Input
            {
                float2 uv_MainTex;
            };

            half _Glossiness;
            half _Metallic;
            fixed4 _Color;

            void surf (Input IN, inout SurfaceOutputStandard o)
            {
                fixed4 color = tex2D (_MainTex, IN.uv_MainTex);
                o.Albedo = color.rgb;
                o.Alpha = color.a;
            }
        ENDCG
    }
    FallBack "Diffuse"
}
