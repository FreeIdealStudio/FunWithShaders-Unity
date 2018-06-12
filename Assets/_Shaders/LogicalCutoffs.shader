Shader "Test/LogicalCutoff" {
	Properties
	{
		_RimColor("Rim Color", Color) = (0,0.5,0.5,0.0)
		_RimPower("Rim Power", Range(0.5, 8.0)) = 3.0
		_StripeWidth("StripeWidth", Range(1,20)) = 10
	}

	SubShader
	{

		CGPROGRAM
		#pragma surface surf Lambert
	
		struct Input 
		{
		float3 viewDir;
		float3 worldPos; //gets world position of the pixel
		};

	float4 _RimColor;
	float _RimPower;
	float _StripeWidth;

		void surf(Input IN, inout SurfaceOutput o) 
		{
			//Normalize to make sure DotProduct is 1 to -1
			//saturate will clamp from 0 to 1 (ignores negative 1)
			half rim = 1.0 - saturate (dot(normalize(IN.viewDir), o.Normal));
			
			//can use logical statements
			//o.Emission = rim > 0.5 ? float3(1,0,0): 0;
			//can nest statements
			//o.Emission = rim > 0.5 ? float3(1, 0, 0) : rim > 0.3 ? float3(0, 1, 0) : 0;
			
			//color based upon world position
			//o.Emission = IN.worldPos.y > 1 ? float3(0, 1, 0) : float3(1, 0, 0);
			
			//frac will divide and look at remainder (can aleternate between values with hard lines to get stripes)
			//o.Emission = frac(IN.worldPos.y*10 *0.5) > 0.4 ? float3(0, 1, 0) : float3(1, 0, 0);
			//reintroduce layered rim controls and stripe controls
			o.Emission = frac(IN.worldPos.y*(20 - _StripeWidth) * 0.5) > 0.4 ?
				float3(0, 1, 0)*rim : float3(1, 0, 0)*rim;
	}
	ENDCG
	}
		FallBack "Diffuse"
}
