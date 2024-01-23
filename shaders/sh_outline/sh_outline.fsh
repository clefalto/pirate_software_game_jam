//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float outlineH;
uniform float outlineW;
uniform vec4 outlineColor;
// uniform vec4 outline_color;
//uniform float width;

// trying and failing to draw an outline on the texture




//bool hasContraryNeighbor(vec2 uv, vec2 texture_pixel_size, sampler2D texture) {
//	for (float i = -ceil(width); i <= ceil(width); i++) {
//		float x = abs(i) > width ? width * sign(i) : i;
//		float offset;
		
//		offset = width - abs(x);
		
//		for (float j = -ceil(offset); j <= ceil(offset); j++) {
//			float y = abs(j) > offset ? offset * sign(j) : j;
//			vec2 xy = uv + texture_pixel_size * vec2(x, y);
			
//			if (xy != clamp(xy, vec2(0.0), vec2(1.0))) {
//				return true;
//			}
//		}
//	}
//	return false;
//}

void main()
{
	//vec2 uv = v_vTexcoord;
	//vec2 texel_size = vec2(pixelW, pixelH);
	
	//vec2 texture_pixel_size = vec2(1.0) / (vec2(1.0) / texel_size + vec2(1.0 * 2.0));

	//uv = (uv - texture_pixel_size * 1.0) * texel_size / texture_pixel_size;
	
	//if (uv != clamp(uv, vec2(0.0), vec2(1.0))) {
	//	gl_FragColor.a = 0.0;
	//} else {
	//	gl_FragColor = texture2D(gm_BaseTexture, uv);
	//}
	
	//if (uv
	// gl_FragColor.rgba = vec4(0.0, uv.y, 0.0, 1.0);
	
	// gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	
	vec2 offsetx;
	offsetx.x = outlineW;
	vec2 offsety;
	offsety.y = outlineH;
  
	float alpha = texture2D( gm_BaseTexture, v_vTexcoord ).a;
	vec4 newColor = texture2D( gm_BaseTexture, v_vTexcoord );
	 
	if ( alpha < 1.0 ) { newColor = outlineColor; } 

	alpha = max(alpha, texture2D( gm_BaseTexture, v_vTexcoord + offsetx).a);
	alpha = max(alpha, texture2D( gm_BaseTexture, v_vTexcoord - offsetx).a);
	alpha = max(alpha, texture2D( gm_BaseTexture, v_vTexcoord + offsety).a);
	alpha = max(alpha, texture2D( gm_BaseTexture, v_vTexcoord - offsety).a);
    
  
	gl_FragColor = newColor;
	gl_FragColor.a = alpha;
}