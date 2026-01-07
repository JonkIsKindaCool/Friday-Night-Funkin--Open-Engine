package engine.audio;

import engine.backend.AudioSystem;
import lime.media.openal.AL;
import lime.media.openal.ALSource;
import engine.backend.AssetsCache;
import lime.media.openal.ALBuffer;

@:allow(engine.backend.AudioSystem)
class Sound {
	private var _buffer:ALBuffer;
	private var _source:ALSource;

	public var volume:Float;

	public var time(get, set):Float;

	private var _time:Float;

	public function new() {
		AudioSystem.sounds.push(this);
	}

	public function loadSong(path:String) {
		_buffer = AssetsCache.cacheSound(path);

		_source = AL.createSource();
		AL.sourcei(_source, AL.BUFFER, _buffer);
		volume = 0.8;

		AL.sourcePlay(_source);
	}

	private var _prevTime:Float;

	public function update(dt:Float) {
		if (_source == null) return;

		AL.sourcef(_source, AL.GAIN, volume * AudioSystem.volume);
		_time = AL.getSourcef(_source, AL.SEC_OFFSET) * 1000;

		if (_prevTime == AL.getSourcef(_source, AL.SEC_OFFSET) * 1000) {
			_time += dt * 1000;
		} else
			_prevTime = AL.getSourcef(_source, AL.SEC_OFFSET) * 1000;
	}

	public function stop() {
		AL.sourceStop(_source);
	}

	public function destroy() {
		AL.deleteSource(_source);
	}

	private function get_time():Float {
		return _time;
	}

	private function set_time(v:Float):Float {
		AL.sourcef(_source, AL.SEC_OFFSET, v / 1000);

		_time = AL.getSourcef(_source, AL.SEC_OFFSET) * 1000;
		return _time;
	}
}
