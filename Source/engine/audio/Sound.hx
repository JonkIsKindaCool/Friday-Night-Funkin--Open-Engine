package engine.audio;

import lime.media.openal.AL;
import lime.media.openal.ALSource;
import engine.backend.AssetsCache;
import lime.media.openal.ALBuffer;

class Sound {
	private var _buffer:ALBuffer;
	private var _source:ALSource;

	public function new(path:String) {
		_buffer = AssetsCache.cacheSound(path);

		_source = AL.createSource();
		AL.sourcei(_source, AL.BUFFER, _buffer);
		AL.sourcef(_source, AL.GAIN, 0.8);

		AL.sourcePlay(_source);
	}

	public function stop() {
		AL.sourceStop(_source);
	}
}
