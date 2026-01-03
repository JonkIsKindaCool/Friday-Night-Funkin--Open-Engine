package engine.utils;

abstract Color(Int) from Int to Int {
	public var r(get, set):Int;
	public var g(get, set):Int;
	public var b(get, set):Int;
	public var a(get, set):Int;

	public var rFloat(get, set):Float;
	public var gFloat(get, set):Float;
	public var bFloat(get, set):Float;
	public var aFloat(get, set):Float;

	public function new(r:Int, g:Int, b:Int, a:Int = 255) {
		this = ((a & 0xFF) << 24) | ((r & 0xFF) << 16) | ((g & 0xFF) << 8) | (b & 0xFF);
	}

	@:from
	public static function fromInt(i:Int):Color {
		if (i < 0x1000000)
			i |= 0xFF000000;
		return i;
	}

	public static function fromFloats(r:Float, g:Float, b:Float, a:Float = 1.0):Color {
		return new Color(fTo8(r), fTo8(g), fTo8(b), fTo8(a));
	}

	inline function get_r():Int
		return (this >> 16) & 0xFF;

	inline function get_g():Int
		return (this >> 8) & 0xFF;

	inline function get_b():Int
		return this & 0xFF;

	inline function get_a():Int
		return (this >>> 24) & 0xFF;

	inline function set_r(v:Int):Int
		return this = (this & 0xFF00FFFF) | ((clamp8(v) & 0xFF) << 16);

	inline function set_g(v:Int):Int
		return this = (this & 0xFFFF00FF) | ((clamp8(v) & 0xFF) << 8);

	inline function set_b(v:Int):Int
		return this = (this & 0xFFFFFF00) | (clamp8(v) & 0xFF);

	inline function set_a(v:Int):Int
		return this = (this & 0x00FFFFFF) | ((clamp8(v) & 0xFF) << 24);

	inline function get_rFloat():Float
		return get_r() / 255.0;

	inline function get_gFloat():Float
		return get_g() / 255.0;

	inline function get_bFloat():Float
		return get_b() / 255.0;

	inline function get_aFloat():Float
		return get_a() / 255.0;

	inline function set_rFloat(v:Float):Float {
		set_r(fTo8(v));
		return clamp01(v);
	}

	inline function set_gFloat(v:Float):Float {
		set_g(fTo8(v));
		return clamp01(v);
	}

	inline function set_bFloat(v:Float):Float {
		set_b(fTo8(v));
		return clamp01(v);
	}

	inline function set_aFloat(v:Float):Float {
		set_a(fTo8(v));
		return clamp01(v);
	}

	inline static function clamp8(v:Int):Int
		return (v < 0) ? 0 : (v > 255 ? 255 : v);

	inline static function clamp01(v:Float):Float
		return (v < 0) ? 0 : (v > 1 ? 1 : v);

	inline static function fTo8(v:Float):Int
		return Std.int(Math.round(clamp01(v) * 255));
}
