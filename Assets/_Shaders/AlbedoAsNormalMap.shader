Shader "Test/AlbedoAsNormalMap" {
	Properties {

		_myDiffuse("Diffuse Texture", 2D) = "white"{}
		_myNormal("Normal Texture", 2D) = "bump"{}
		_mySlider ("Bump Amount", Range(0,10)) =1

	}

	SubShader {

		CGPROGRAM
		#pragma surface surf Lambert

		fixed4 _myColour;
		sampler2D _myDiffuse;
		sampler2D _myNormal;
		half _mySlider;

		struct Input {
			float2 uv_myDiffuse;
			float2 uv_myNormal;
		};

		


		void surf (Input IN, inout SurfaceOutput o) {

			o.Albedo = o.Normal;
			//o.Normal = UnpackNormal(tex2D(_myNormal, IN.uv_myNormal));
			//o.Normal *= float3(_mySlider, _mySlider, 1); //use slider to multiply the normal value (dont affect the Z axis)

		}
		ENDCG
	}
	FallBack "Diffuse"
}
