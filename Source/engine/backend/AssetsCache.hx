package engine.backend;

import haxe.Log;
import lime.media.AudioBuffer;
import lime.media.openal.AL;
import lime.media.openal.ALBuffer;
import lime.graphics.opengl.GLBuffer;
import engine.graphics.Texture;

class AssetsCache {
	private static final _imagesCache:Map<String, Texture> = new Map<String, Texture>();
	private static final _soundCache:Map<String, ALBuffer> = new Map<String, ALBuffer>();

	public static function cacheImage(path:String):Texture {
		if (_imagesCache.exists(path))
			return _imagesCache.get(path);

		var texture:Texture = new Texture(path);
		_imagesCache.set(path, texture);
		return texture;
	}

	public static function cacheSound(path:String):ALBuffer {
		if (_soundCache.exists(path))
			return _soundCache.get(path);

		var soundBuffer:AudioBuffer = AudioBuffer.fromFile(path);

		var format:Int = switch (soundBuffer.channels) {
			case 1: soundBuffer.bitsPerSample == 8 ? AL.FORMAT_MONO8 : AL.FORMAT_MONO16;
			case 2: soundBuffer.bitsPerSample == 8 ? AL.FORMAT_STEREO8 : AL.FORMAT_STEREO16;
			default:
				Logger.error('Unsopported Format: ${soundBuffer.channels} channels, ${soundBuffer.bitsPerSample} bits');
				Sys.exit(1);
				0;
		}

		var buffer:ALBuffer = AL.createBuffer();
		AL.bufferData(buffer, format, soundBuffer.data, soundBuffer.data.toBytes().length, soundBuffer.sampleRate);

		soundBuffer.dispose();
		
		return buffer;
	}
}
