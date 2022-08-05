Shader "Custom/Example8 Vertex Color Masking"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2 ("Albedo (RGB)", 2D) = "white" {}
        _MainTex3 ("Albedo (RGB)", 2D) = "white" {}
        _MainTex4 ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard noambient
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _MainTex2;
        sampler2D _MainTex3;
        sampler2D _MainTex4;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;
            float2 uv_MainTex3;
            float2 uv_MainTex4;
            float4 color: COLOR;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 d = tex2D (_MainTex2, IN.uv_MainTex2);
            fixed4 e = tex2D (_MainTex3, IN.uv_MainTex3);
            fixed4 f = tex2D (_MainTex4, IN.uv_MainTex4);

            // o.Albedo = lerp(c.rgb, d.rgb, IN.color.r);
            // o.Albedo = lerp(o.Albedo.rgb, e.rgb, IN.color.g);
            // o.Albedo = lerp(o.Albedo.rgb, f.rgb, IN.color.b);
            o.Albedo = d.rgb * IN.color.r + e.rgb * IN.color.g + f.rgb * IN.color.b + c.rgb * (1 - (IN.color.r + IN.color.g + IN.color.b));
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
