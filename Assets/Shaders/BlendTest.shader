Shader "Holistic/BlendTest"
{
    Properties
    {
        _MainTex("Texture", 2D) = "black" {}
        _Transparency("Transparency", Range(0, 1)) = 1.0
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" }

        CGPROGRAM
        
            #pragma surface surf Standard fullforwardshadows
            #pragma target 3.0

            sampler2D _MainTex;
            
            struct Input
            {
                float2 uv_MainTex;
            };

            void surf (Input IN, inout SurfaceOutputStandard o)
            {
                o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgba;
                // o.Alpha = o.Albedo.a * _Transparency * 100;
            }
        
        ENDCG
    }
}
