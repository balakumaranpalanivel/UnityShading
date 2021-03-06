Shader "DT/Basic/Texture"
{
Properties
{
	_MainTex("Texture", 2D) = "white"{}
	_BumpMap("Bumpmap", 2D) = "bump"{}
}
	SubShader
	{
		Tags {"RenderType"="Opaque"}
		CGPROGRAM
		// include the lambert shader here
		#pragma surface surf Lambert
		struct Input
		{
			float2 uv_MainTex; // (1.0, 1,0) U, V
			float2 uv_BumpMap;
			//float4 color : COLOR; //(1.0, 1.0, 1.0, 1.0) R, G, B, A
		};
		sampler2D _MainTex;
		sampler2D _BumpMap;
		
		void surf(Input IN, inout SurfaceOutput o)
		{
			// Albedo is keyworkd for color
			// fills the color value of 1 for r,g,b,a
			//o.Albedo = 1;
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
		}
		ENDCG
		// For each subshader we need fallback
		Fallback "Diffuse"
	}
}