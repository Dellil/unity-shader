Shader "Custom/Example9 MS"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Metallic ("Metalic", Range(0, 1)) = 0
        _Smoothness ("Smoothness", Range(0, 1)) = 0.5
        _BumpMap("Normalmap", 2D) = "bump" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _BumpMap;
        float _Metallic;
        float _Smoothness;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            float3 d = UnpackNormal(tex2D (_BumpMap, float2(IN.uv_BumpMap.x , IN.uv_BumpMap.y + _Time.y)));
            o.Normal = float3(d.x * 0.5, d.y * 0.5, d.z);
            o.Albedo = c.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = _Smoothness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
