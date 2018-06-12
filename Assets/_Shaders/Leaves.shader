Shader "Test/Leaves" {
	Properties{
		_MainTex("MainTex", 2D) = "white"{}

	}

		SubShader{
		Tags{
		//make sure queued with transparent as will get missed from zbuffer otherwise
		"Queue" = "Transparent"
}

		CGPROGRAM
		//add alpha mode after lighting model
		#pragma surface surf Lambert alpha:fade

	sampler2D _MainTex;

		

	struct Input {
		float2 uv_MainTex;
	};




	void surf(Input IN, inout SurfaceOutput o) {
		//set to fixed 4 to get alpha too
		fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
		o.Albedo = c.rgb;
		o.Alpha = c.a;


	}
	ENDCG
	}
		FallBack "Diffuse"
}
