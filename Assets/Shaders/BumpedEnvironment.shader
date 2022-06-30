Shader "Holistic/BumpedEnvironment"
{
    Properties
    {
        _diffuseTexture ("Diffuse Texture", 2D) = "white" {}
        _bumpTexture ("Bump Texture", 2D) = "bump" {}
        _bumpAmount ("Bump Amount", Range(0, 10)) = 1
        _brightness ("Brightness", Range(0, 10)) = 1
    }
    SubShader
    {
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _diffuseTexture;
        sampler2D _bumpTexture;
        half _bumpAmount;
        half _brightness;

        struct Input
        {
            float2 uv_diffuseTexture;
            float2 uv_bumpTexture;
        };

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = tex2D(_diffuseTexture, IN.uv_diffuseTexture).rgb;
            o.Normal = UnpackNormal(tex2D(_bumpTexture, IN.uv_bumpTexture)) * _brightness;

            // multiplies the bump amount by a float3 which corresponds to it's xyz values (or potentially rgb values in other circumstances)
            o.Normal *= float3(_bumpAmount, _bumpAmount, 1);
        }

        ENDCG
    }
    FallBack "Diffuse"
}
