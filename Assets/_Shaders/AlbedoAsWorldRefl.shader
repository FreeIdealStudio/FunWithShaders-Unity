Shader "Test/AlbedoAsWorldRefl" {
	Properties {

	}

	SubShader {

		CGPROGRAM
		#pragma surface surf Lambert


		struct Input {
			float3 wordRefl;
		};


		void surf (Input IN, inout SurfaceOutput o) {

			//o.Albedo = IN.worldRefl;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
