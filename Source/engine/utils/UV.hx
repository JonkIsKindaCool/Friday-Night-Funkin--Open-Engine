package engine.utils;

import lime.math.Vector2;

class UV {
	public static inline function uvToCoordinates(u:Float, v:Float, w:Float, h:Float):Vector2
		return new Vector2(w * u, h * v);

	public static inline function coordinatesToUv(x:Float, y:Float, w:Float, h:Float):Vector2
		return new Vector2(x / w, y / h); 
}