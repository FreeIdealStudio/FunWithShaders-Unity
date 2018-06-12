Shader "Test/Hologram" {
	Properties
	{
		_RimColor("Rim Color", Color) = (0,0.5,0.5,0.0)
		_RimPower("Rim Power", Range(0.5, 8.0)) = 3.0
	}

	SubShader
	{
		Tags{"Queue" = "Transparent"}

	Pass{
		//To hide the internals of the geometry mesh
		//Force write to Z Buffer
		ZWrite On
		//dont write colour into the frame buffer 
		ColorMask 0
		//Write colour ro debug the zbuffer
		//ColorMask RGB
	}

		CGPROGRAM
		#pragma surface surf Lambert alpha:fade
	
		struct Input 
		{
		float3 viewDir;
		};

	float4 _RimColor;
	float _RimPower;

		void surf(Input IN, inout SurfaceOutput o) 
		{
			//Normalize to make sure DotProduct is 1 to -1
			//saturate will clamp from 0 to 1 (ignores negative 1)
			half rim = 1.0 - saturate (dot(normalize(IN.viewDir), o.Normal));
			//pow will take value to a power of a float, can be used to control the gradient falloff
			o.Emission = _RimColor.rgb * pow(rim, _RimPower);
			//remove centre of hologram using rim and power
			o.Alpha = pow(rim, _RimPower);

	}
	ENDCG
	}
		FallBack "Diffuse"
}
