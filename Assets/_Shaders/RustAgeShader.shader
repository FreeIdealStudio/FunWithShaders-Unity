﻿Shader "FunWithShaders/RustAgeShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainATex ("Albedo (RGB)", 2D) = "white" {}
        _MainBTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
        _Blend ("Blend", Range (0,1)) = 0.0 
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainATex;
        sampler2D _MainBTex;

		struct Input {
			float2 uv_MainATex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
        float _Blend;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {

        fixed4 a = tex2D(_MainATex, IN.uv_MainATex);
        fixed4 b = tex2D(_MainBTex, IN.uv_MainATex) * _Blend;


			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainATex, IN.uv_MainATex) * _Color;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
