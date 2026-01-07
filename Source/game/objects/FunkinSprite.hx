package game.objects;

import lime.math.Vector2;
import game.backend.Conductor;
import engine.animations.FramesGenerator;
import game.utils.AnimType;
import engine.animations.Frame;
import engine.entities.display.AnimatedSprite;
import engine.entities.display.Sprite;

class FunkinSprite extends AnimatedSprite {
	public function new(x:Float, y:Float, path:String, ?animType:AnimType) {
		var frames:Map<String, Frame> = switch (animType) {
			case SPARROW:
				FramesGenerator.fromSparrowAtlas(path + ".xml");
		};
		super(path + ".png", frames, x, y);

		Conductor.onBeat.add(onBeat);
		Conductor.onStep.add(onStep);
	}

	override function destroy() {
		super.destroy();

		Conductor.onBeat.remove(onBeat);
		Conductor.onStep.remove(onStep);
	}

	public inline function addAnimationByPrefix(n:String, p:String, fps:Int, offset:Vector2, ?loop:Bool = true)
		animation.addAnimationByPrefix(n, p, fps, loop, offset);

	public inline function addAnimationByIndices(n:String, p:String, i:Array<Int>, fps:Int, offset:Vector2, ?loop:Bool = true)
		animation.addAnimationByIndices(n, p, i, fps, loop, offset);

	public inline function playAnimation(n:String, f:Bool = true)
		animation.playAnimation(n, f);

	public inline function hasAnimation(n:String):Bool
		return animation.hasAnimation(n);

	private var danced:Bool = true;

	public function dance() {
		if (hasAnimation('danceLeft')) {
			if (danced)
				playAnimation('danceLeft', true);
			else
				playAnimation('danceRight', true);

			danced = !danced;
		} else if (hasAnimation('idle'))
			playAnimation('idle', true);
	}

	private function onBeat(b:Int) {
		dance();
	}

	private function onStep(b:Int) {}
}
