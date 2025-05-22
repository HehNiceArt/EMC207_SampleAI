Shader "Unlit/checker"
{
    Properties
    {
        _Density("Density", Range(2, 100)) = 50
        _MainTex("Texture", 2D) = "white" {}
        _CheckerColor("Checker Color", Color) = (1, 1, 1, 1)
        _BackgroundColor("Background Color", Color) = (0, 0, 0, 1)
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"


            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float2 checkerUV : TEXCOORD1;
                float4 vertex : SV_POSITION;
            };

            float _Density;
            sampler2D _MainTex;
            fixed4 _CheckerColor;
            fixed4 _BackgroundColor;
/*
            v2f vert (float4 pos : POSITION, float2 uv : TEXCOORD0)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(pos);
                o.uv = uv * Density;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 c = i.uv;
                fixed4 tex = tex2D(_MainTex, c);
                c = floor(c) / 2;
                float col = frac(c.x + c.y) * 2;
                return col * tex;
            }
*/
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.checkerUV = v.uv * _Density; // only scale checker pattern
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // Sample base texture using unscaled UVs
                fixed4 texColor = tex2D(_MainTex, i.uv);

                // Checker pattern using scaled UVs
                float2 coord = floor(i.checkerUV);
                float checker = fmod(coord.x + coord.y, 2.0);

                fixed4 checkerColor = lerp(_BackgroundColor, _CheckerColor, checker);
                return texColor * checkerColor ;
            }
            ENDCG
        }
    }
}
