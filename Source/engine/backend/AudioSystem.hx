package engine.backend;

import lime.app.Event;
import engine.audio.Sound;
import lime.media.openal.ALContext;
import lime.media.openal.AL;
import lime.media.openal.ALC;
import lime.media.openal.ALDevice;

class AudioSystem {
	public static var device:ALDevice;
	public static var context:ALContext;
	public static var volume(default, set):Float = 1;
	public static var onVolumeChange:Event<Float->Void> = new Event<Float->Void>();

	public static var sounds:Array<Sound>;

	public static function init() {
		var defaultDevice:String = ALC.getString(null, ALC.DEFAULT_DEVICE_SPECIFIER);
		device = ALC.openDevice(defaultDevice);
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
		if (InputSystem.getJustPressed(MINUS)) {
			volume -= 0.1;
		}

		if (InputSystem.getJustPressed(PLUS)) {
			volume += 0.1;
		}

		volume = Math.max(0, Math.min(1, volume));

		for (i in sounds) {
			i.update(dt);
		}
	}

	public static function exit() {
		onVolumeChange.removeAll();
		ALC.destroyContext(context);
		ALC.closeDevice(device);

		for (i in sounds) {
			i.destroy();
		}
	}

	private static function set_volume(v:Float):Float {
		v = Math.min(1, Math.max(0, v));
		onVolumeChange.dispatch(v);
		return volume = v;
	}
}
