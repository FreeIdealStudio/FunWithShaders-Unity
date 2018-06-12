Shader "Test/RimLighting" {
	Properties
	{
		_RimColor("Rim Color", Color) = (0,0.5,0.5,0.0)
		_RimPower("Rim Power", Range(0.5, 8.0)) = 3.0
	}

	SubShader
	{

		CGPROGRAM
		#pragma surface surf Lambert
	
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

	}
	ENDCG
	}
		FallBack "Diffuse"
}
