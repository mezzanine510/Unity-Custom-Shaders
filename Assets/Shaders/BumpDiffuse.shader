Shader "Holistic/BumpDiffuse"
{
    Properties
    {
        _myDiffuse("Diffuse Texture", 2D) = "white" {}
        _myBump("Bump Texture", 2D) = "bump" {}
        _bumpAmount("Bump Amount", Range(0, 10)) = 1
        _bumpScale("Bump Scale", Range(0.5, 2)) = 1
    }
    SubShader
    {
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _myDiffuse;
        sampler2D _myBump;
        half _bumpAmount;
        half _bumpScale;

        struct Input
        {
            float2 uv_myDiffuse;
            float2 uv_myBump;
        };

        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse * _bumpScale).rgb;
            o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump * _bumpScale));

            o.Normal *= float3(_bumpAmount, _bumpAmount, 1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
