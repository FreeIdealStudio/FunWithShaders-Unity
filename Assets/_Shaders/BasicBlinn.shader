Shader "Test/BasicBlinn" {
	Properties{
		_Color("Main Colour", Color) = (1,1,1,1)
		_SpecColor("Spec Colour", Color) = (1,1,1,1) //SpecColor doesnt need to be defined as part of Unity build (check spelling)
		_Spec("Specular", Range(0,1)) =0.5
		_Gloss("Gloss", Range(0,1)) =0.5


	}

		SubShader{
		Tags{
		"Queue" = "Geometry"
}

		CGPROGRAM
		#pragma surface surf BlinnPhong

		fixed4 _Color;
	half _Spec;
	fixed _Gloss;
		

	struct Input {
		float2 uv_myTex;
	};




	void surf(Input IN, inout SurfaceOutput o) {
		o.Albedo = _Color.rgb;
		o.Specular = _Spec;
		o.Gloss = _Gloss;

	}
	ENDCG
	}
		FallBack "Diffuse"
}
