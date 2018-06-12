Shader "Test/CustomLightingBasicLambert" {
	Properties{
		_Color("Main Colour", Color) = (1,1,1,1)

	}

		SubShader{
		Tags{
		"Queue" = "Geometry"
}

		CGPROGRAM
		#pragma surface surf BasicLambert

		//'Lighting' needs to prefix lighting model name
		//atten is intensity
		half4 LightingBasicLambert(SurfaceOutput s, half3 lightDir, half atten) {
		//first work out dot product from source and normal
			half NdotL = dot(s.Normal, lightDir);
			half4 c;
			//_LightColor0 is the scene lighting colour
			//.s is surface
			c.rgb = s.Albedo * _LightColor0.rgb * (NdotL *atten);
			c.a = s.Alpha;
			return c;
}

		float4 _Color;

		

	struct Input {
		float2 uv_MainTex;
	};




	void surf(Input IN, inout SurfaceOutput o) {
		o.Albedo = _Color.rgb;


	}
	ENDCG
	}
		FallBack "Diffuse"
}
