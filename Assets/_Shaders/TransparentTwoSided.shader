Shader "Test/TransparentTwoSided" {
	Properties{

		_MainTex("Texture", 2D) = "black"{}

	}

		SubShader{
			Tags
			{
				"Queue" = "Transparent"
			}


			//Standard alpha transparent blend
			Blend SrcAlpha OneMinusSrcAlpha
			Cull off

			Pass
			{
				//replacing pixels in framebuffer with texture
				SetTexture[_MainTex] {combine texture}
			}

		}
}