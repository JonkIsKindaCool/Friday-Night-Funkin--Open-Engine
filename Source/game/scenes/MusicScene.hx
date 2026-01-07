package game.scenes;

import game.backend.Conductor;
import engine.Scene;

class MusicScene extends Scene {
	@:isVar public var curBeat(get, never):Int = 0;
	@:isVar public var curStep(get, never):Int = 0;

	public function new() {
		super();
		Conductor.onBeat.add(onBeat);
		Conductor.onStep.add(onStep);
	}

	private function onBeat(b:Int) {}

	private function onStep(s:Int) {}

	override function destroy() {
		super.destroy();
		Conductor.onBeat.remove(onBeat);
		Conductor.onStep.remove(onStep);
	}

	private function get_curBeat():Int {
		return Conductor.curBeat;
	}

	private function get_curStep():Int {
		return Conductor.curStep;
	}
}
