Shader "Test/BasicTextureBlend" {
	Properties{
		_MainTex("MainTex", 2D) = "white" {}
		_DecalTex("Decal", 2D) = "white" {}
		//no bools so use float toggle with 0 / 1
		[Toggle] _ShowDecal ("ShowDecal?", Float) =0
	}

		SubShader{
		Tags{
			"Queue" = "Geometry"
		}

		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _DecalTex;
		float _ShowDecal;

	struct Input {
		float2 uv_MainTex;
	};




	void surf(Input IN, inout SurfaceOutput o) {
		fixed4 a = tex2D(_MainTex, IN.uv_MainTex);
		fixed4 b = tex2D(_DecalTex, IN.uv_MainTex) * _ShowDecal;
			//o.Albedo = a.rgb * b.rgb;

			//check if b has color, if so use b, otherwise use a
			o.Albedo = b.r > 0.9 ? b.rgb : a.rgb;
	}
	ENDCG
	}
		FallBack "Diffuse"
}
