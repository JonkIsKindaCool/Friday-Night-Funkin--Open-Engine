package engine.animations;

import engine.graphics.Texture;
import lime.math.Vector2;
import lime.math.Rectangle;
import engine.backend.AssetsCache;

using StringTools;

@:publicFields
class AnimationManager {
	var _texture:Texture;
	var _animations:Map<String, Animation>;
	var _nextAnimation:String;

	var animationIndex:Float = 0;

	var frames:Map<String, Frame>;
	var currentAnimation:Animation;

	public function new(t:Texture, frames:Map<String, Frame>) {
		_texture = t;

		this.frames = frames;
		_animations = new Map();
		currentAnimation = {
			frames: [
				{
					rect: new Rectangle(0, 0, _texture.width, _texture.height),
					offset: new Vector2(0, 0)
				}
			],
			framerate: 1,
			loop: true
		}

		_animations.set('__default__', currentAnimation);
	}

	public function addAnimationByPrefix(name:String, prefix:String, framerate:Float, ?loop:Bool = true) {
		var frames:Array<Frame> = [];

		var candidates:Array<{frame:Frame, num:Float}> = [];
		var prefixLen:Int = prefix.length;

		for (k => v in this.frames) {
			if (k.startsWith(prefix)) {
				var suffix:String = k.substr(prefixLen);

				var match = ~/^(\d+)$/;
				if (match.match(suffix)) {
					var num:Float = Std.parseFloat(match.matched(1));
					candidates.push({frame: v, num: num});
				}
			}
		}

		if (candidates.length > 0) {
			candidates.sort(function(a, b) return Reflect.compare(a.num, b.num));

			for (c in candidates) {
				frames.push(c.frame);
			}
		}

		_animations.set(name, {
			framerate: framerate,
			frames: frames,
			loop: loop
		});
	}

	public function addAnimationByIndices(name:String, prefix:String, indices:Array<Int>, framerate:Float, ?loop:Bool = true) {
		var frames:Array<Frame> = [];

		var candidates:Array<{frame:Frame, num:Float}> = [];
		var prefixLen:Int = prefix.length;

		for (k => v in this.frames) {
			if (k.startsWith(prefix)) {
				var suffix:String = k.substr(prefixLen);

				var match = ~/^(\d+)$/;
				if (match.match(suffix)) {
					var num:Float = Std.parseFloat(match.matched(1));
					if (indices.contains(Std.int(num)))
						candidates.push({frame: v, num: num});
				}
			}
		}

		if (candidates.length > 0) {
			candidates.sort(function(a, b) return Reflect.compare(a.num, b.num));

			for (c in candidates) {
				frames.push(c.frame);
			}
		}

		_animations.set(name, {
			framerate: framerate,
			frames: frames,
			loop: loop
		});
	}

	private function getEndingNumber(s:String):Float {
		var i:Int = s.length - 1;
		var digits:String = "";

		while (i >= 0) {
			var c:String = s.charAt(i);
			if (c >= "0" && c <= "9") {
				digits = c + digits;
				i--;
			} else {
				break;
			}
		}

		return (digits == "") ? 0 : Std.parseFloat(digits);
	}

	public function playAnimation(name:String, ?force:Bool = true) {
		var anim = _animations.get(name);
		if (anim == null) {
			trace('Animation $name not found');
			return;
		}

		if (force || _nextAnimation == null) {
			currentAnimation = anim;
			animationIndex = 0;
			_nextAnimation = null;
		} else {
			_nextAnimation = name;
		}
	}

	public function update(dt:Float) {
		if (animationIndex >= currentAnimation.frames.length) {
			if (currentAnimation.loop)
				animationIndex = 0;

			if (_nextAnimation != null) {
				currentAnimation = _animations.get(_nextAnimation);
				_nextAnimation = null;
				animationIndex = 0;
			}
		} else
			animationIndex += dt * currentAnimation.framerate;
	}
}
