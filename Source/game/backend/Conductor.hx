package game.backend;

import lime.app.Application;
import lime.app.Event;
import engine.audio.Sound;

class Conductor {
	public static var music:Sound;
	public static var bpm(default, set):Int;

	public static var stepTime:Float;
	public static var beatTime:Float;

	public static var curBeat:Int;
	public static var curStep:Int;

    public static var onBeat:Event<Int->Void>;
    public static var onStep:Event<Int->Void>;

	public static function init() {
		music = new Sound();
        
        Application.current.onUpdate.add(update);

        onBeat = new Event<Int->Void>();
        onStep = new Event<Int->Void>();
	}

	public static function loadSong(song:String, bpm:Int) {
		music.loadSong(song);
		Conductor.bpm = bpm;
	}

	private static var _prevBeat:Int = 0;
	private static var _prevStep:Int = 0;

	public static function update(dt:Float) {
        dt /= 1000;

		@:privateAccess
		if (music._source == null)
			return;

		curBeat = Math.floor(music.time / beatTime);
		curStep = Math.floor(music.time / stepTime);

		if (curBeat != _prevBeat)
            onBeat.dispatch(curBeat);

		if (curStep != _prevStep)
            onStep.dispatch(curStep);

		_prevBeat = curBeat;
		_prevStep = curStep;
	}

	public static function destroy() {
        Application.current.onUpdate.remove(update);

        onBeat.removeAll();
        onStep.removeAll();

        onBeat = null;
        onStep = null;
    }

	private static function set_bpm(v:Int):Int {
		bpm = v;
		beatTime = 60000 / bpm;
		stepTime = beatTime / 4;
		return bpm;
	}
}
