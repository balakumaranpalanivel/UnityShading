Shader "DT/Basic/SimpleShader_White"
{
	SubShader
	{
		Tags {"RenderType"="Opaque"}
		CGPROGRAM
		// include the lambert shader here
		#pragma surface surf Lambert
		struct Input
		{
			float4 color : COLOR; //(1.0, 1.0, 1.0, 1.0) R, G, B, A
		};
		
		void surf(Input IN, inout SurfaceOutput o)
		{
			// Albedo is keyworkd for color
			// fills the color value of 1 for r,g,b,a
			o.Albedo = 1;
		}
		ENDCG
		// For each subshader we need fallback
		Fallback "Diffuse"
	}
}