Shader "Test/BlendTest" {
	Properties{

		_MainTex("Texture", 2D) = "black"{}

	}

		SubShader{
			Tags
			{
				"Queue" = "Transparent"
			}

			//blend followed by the incoming colour mult, then the current colour mult (what is in frame buffer) - then they are added together
			//pixel x 1, then framebuffer colour x 1, then both added together
			//Good for particle effects
			//Blend One One

			//Standard alpha transparent blend
			//Blend SrcAlpha OneMinusSrcAlpha

			//Soft Additive Blend
			//Can use to fake transparency
			//Destination colour + zero
			Blend DstColor Zero

			Pass
			{
				//replacing pixels in framebuffer with texture
				SetTexture[_MainTex] {combine texture}
			}

		}
}