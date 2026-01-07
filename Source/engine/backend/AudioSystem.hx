package engine.backend;

import engine.audio.Sound;
import lime.media.openal.ALContext;
import lime.media.openal.AL;
import lime.media.openal.ALC;
import lime.media.openal.ALDevice;

class AudioSystem {
	public static var device:ALDevice;
	public static var context:ALContext;
	public static var volume:Float = 1;

	public static var sounds:Array<Sound>;

	public static function init() {
		device = ALC.openDevice(null);
		if (device == null) {
			Logger.error("ERROR: Couldnt open OPENAL device");
			Sys.exit(1);
		}

		context = ALC.createContext(device, null);
		if (context == null || !ALC.makeContextCurrent(context)) {
			Logger.error("ERROR: Could'nt create OPENAL Context");
			ALC.closeDevice(device);
			device = null;
			Sys.exit(1);
		}

		AL.distanceModel(AL.INVERSE_DISTANCE_CLAMPED);
		AL.dopplerFactor(1.0);

		sounds = [];

		trace("Audio System Initialized");
	}

	public static function update(dt:Float) {
		if (InputSystem.getJustPressed(MINUS))
			volume -= 0.1;

		if (InputSystem.getJustPressed(PLUS))
			volume += 0.1;
		
		volume = Math.max(0, Math.min(1, volume));

		for (i in sounds) {
			i.update(dt);
		}
	}

	public static function exit() {
		ALC.destroyContext(context);
		ALC.closeDevice(device);

		for (i in sounds) {
			i.destroy();
		}
	}
}
