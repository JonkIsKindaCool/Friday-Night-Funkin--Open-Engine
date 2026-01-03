package engine.backend;

import lime.media.openal.ALContext;
import lime.media.openal.AL;
import lime.media.openal.ALC;
import lime.media.openal.ALDevice;

class AudioSystem {
	public static var device:ALDevice;
	public static var context:ALContext;

	public static function init() {
		device = ALC.openDevice(null);
		if (device == null) {
			Logger.error("ERROR: No se pudo abrir dispositivo OpenAL");
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

		trace("Audio System Initialized");
	}
}
