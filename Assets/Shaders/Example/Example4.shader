Shader "Custom/Example4"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _FlowSpeed("Flow Speed", Range(0, 2)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard
        #pragma target 3.0

        sampler2D _MainTex;
        float _FlowSpeed;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float2 uv = IN.uv_MainTex;
            float2 modifiedUV = float2(uv.x + _Time.y * _FlowSpeed, uv.y + _Time.y * _FlowSpeed);
            fixed4 c = tex2D (_MainTex, modifiedUV);
            o.Albedo = float3(modifiedUV.x, modifiedUV.y, 0);
            // o.Albedo = c.xyz;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
