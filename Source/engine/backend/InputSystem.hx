package engine.backend;

import lime.app.Application;
import lime.ui.KeyModifier;
import lime.ui.KeyCode;
import haxe.ds.IntMap;

class InputSystem {
	@:noCompletion
	public static final _KEY_PRESSED:Map<KeyCode, Bool> = new Map();

	@:noCompletion
	public static final _KEY_JUST_PRESSED:Map<KeyCode, Bool> = new Map();

	@:noCompletion
	public static final _KEY_JUST_RELEASED:Map<KeyCode, Bool> = new Map();

	@:noCompletion
	public static function init() {
		Application.current.window.onKeyDown.add(onKeyDown);
		Application.current.window.onKeyUp.add(onKeyUp);
	}

	public inline static function getPressed(k:KeyCode)
		return _KEY_PRESSED.get(k);

	public inline static function getJustPressed(k:KeyCode)
		return _KEY_JUST_PRESSED.get(k);

	public inline static function getJustReleased(k:KeyCode)
		return _KEY_JUST_RELEASED.get(k);

	@:noCompletion
	public static function update() {
		for (k => i in _KEY_JUST_PRESSED)
			_KEY_JUST_PRESSED.set(k, false);

		for (k => i in _KEY_JUST_RELEASED)
			_KEY_JUST_RELEASED.set(k, false);
	}

	private static function onKeyDown(k:KeyCode, m:KeyModifier) {
		if (!_KEY_PRESSED.get(k))
			_KEY_JUST_PRESSED.set(k, true);

		_KEY_PRESSED.set(k, true);
	}

	private static function onKeyUp(k:KeyCode, m:KeyModifier) {
		if (_KEY_PRESSED.get(k))
			_KEY_JUST_RELEASED.set(k, true);

		_KEY_PRESSED.set(k, false);
	}
}
