Shader "Test/BumpedEnvironment" {
	//use to mix normal map and enviroment reflections
	//may want to change model normals to calculate and weighted angle

	Properties {

		_myDiffuse("Diffuse Texture", 2D) = "white"{}
		_myBump("Normal Texture", 2D) = "bump"{}
		_mySlider ("Bump Amount", Range(0,10)) =0.9	
			_myBright ("Brightness", Range(0,10))=0.1
			_myCube("Cube map", CUBE) = "white"{}

	}

	SubShader {

		CGPROGRAM
		#pragma surface surf Lambert

		fixed4 _myColour;
		sampler2D _myDiffuse;
		sampler2D _myBump;
		half _mySlider;
		half _myBright;
		samplerCUBE _myCube;

		struct Input {
			float2 uv_myDiffuse;
			float2 uv_myBump;
			float3 worldRefl; INTERNAL_DATA //allows distinction between worldrefl and normal so they can be separately mixed
		};

		


		void surf (Input IN, inout SurfaceOutput o) {

			o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
			//o.Albedo = texCUBE(_myCube, IN.worldRefl).rgb; //debug solo for reflections
			o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump))* _myBright;
			o.Normal *= float3(_mySlider, _mySlider, 1); 
			o.Emission = texCUBE(_myCube, WorldReflectionVector(IN, o.Normal)).rgb;
			
			//Or a metallic reflective bump mapped surface
			//o.Albedo = texCUBE(_myCube, WorldReflectionVector(IN, o.Normal)).rgb;
			//o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump))* 0.3;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
