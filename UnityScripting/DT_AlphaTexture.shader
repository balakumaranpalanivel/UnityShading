Shader "DT/Basic/AlphaTexture"
{
Properties
{
	_MainTex("Texture", 2D) = "white"{}
	_BumpMap("Bumpmap", 2D) = "bump"{}
	_SpecMap("SpecularMap", 2D) = "black"{}
	_SpecColor("Specular Color", Color) = (0.5, 0.5, 0.5, 1.0)
	_SpecPower("Specular Power", Range(0, 1)) = 0.5
	_Cutoff("Alpha Cutoff", Range(0, 1)) = 0.5
}
	SubShader
	{
		Tags {"RenderType"="Opaque" "Queue" = "AlphaTest"}
		CGPROGRAM
		// include the lambert shader here
		#pragma surface surf BlinnPhong alphatest:_Cutoff
		#pragma exclude_renderers flash

		struct Input
		{
			float2 uv_MainTex; // (1.0, 1,0) U, V
			float2 uv_BumpMap;
			float2 uv_SpecMap;
			//float4 color : COLOR; //(1.0, 1.0, 1.0, 1.0) R, G, B, A
		};
		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _SpecMap;
		float _SpecPower;
		
		void surf(Input IN, inout SurfaceOutput o)
		{
			// Albedo is keyworkd for color
			// fills the color value of 1 for r,g,b,a
			//o.Albedo = 1;
			fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
			fixed4 specTex = tex2D(_SpecMap, IN.uv_SpecMap);
			
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			o.Specular = _SpecPower;
			o.Gloss = specTex.rgb;
			o.Alpha = tex.a;
			
		}
		ENDCG
		// For each subshader we need fallback
		Fallback "Diffuse"
	}
}