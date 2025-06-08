Shader "Shaders/SilhouetteShader"
{
    /*	Define the _NearColour and _FarColour in the Properties so they could
		be modified easily (in scripting or in the Inspector in Unity if this
		shader is used in a material).
	*/
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_NearColour ("Near Clip Colour", Color) = (0.75, 0.35, 0, 1)
		_FarColour  ("Far Clip Colour", Color)  = (1, 1, 1, 1)
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag

            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4    _MainTex_ST;
			// Include the depth texture so we can use depth buffer values.
			sampler2D _CameraDepthTexture;
			fixed4 _NearColour;
			fixed4 _FarColour;

            float GetLinearDepth(float2 uv) {
                float rawDepth = UNITY_SAMPLE_DEPTH(tex2D(_CameraDepthTexture, uv));
                return Linear01Depth(rawDepth);
            }

			/*	Calculate the depth value, modify it slightly so it is in a more
				acceptable range, then use lerp() to pick the correct colour on
				a scale between _NearColour and _FarColour.
			*/
            fixed4 frag (v2f_img i) : SV_Target
            {
                float2 texelSize = float2(1.0/_ScreenParams.x, 1.0/_ScreenParams.y);

                float center = GetLinearDepth(i.uv);
                float left = GetLinearDepth(i.uv + float2(-texelSize.x, 0));
                float right = GetLinearDepth(i.uv + float2(texelSize.x, 0));
                float up = GetLinearDepth(i.uv + float2(0, texelSize.y));
                float down = GetLinearDepth(i.uv + float2(0, -texelSize.y));

                float diff = abs(center - left) + abs(center - right) + abs(center - up) + abs(center - down);
                float edge = step(0.01, diff);

                return lerp(_FarColour, _NearColour, edge);
            }
            ENDCG
        }
    }
}
