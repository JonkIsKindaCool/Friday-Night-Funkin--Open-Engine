package engine.backend;

import haxe.Json;
import sys.io.File;
import sys.FileSystem;
import lime.system.System;

class SaveSystem {
	public static var directory(get, never):String;
	public static var configPath(get, never):String;
    public static var data:Dynamic;

	public static function init() {
		if (!FileSystem.exists(directory)) {
			try {
				FileSystem.createDirectory(directory);
			} catch (err:Dynamic) {
				Logger.error(directory);
				Sys.exit(1);
			}
		}

		if (!FileSystem.exists(configPath)) {
			try {
				File.saveContent(configPath, '{}');
			} catch (err:Dynamic) {
				Logger.error(directory);
				Sys.exit(1);
			}
		}

        data = Json.parse(File.getContent(configPath));
	}

	public static function saveData(name:String, v:Dynamic) {
		Reflect.setField(data, name, v);

		File.saveContent(configPath, Json.stringify(data));
	}

	private static function get_directory():String {
		return System.applicationStorageDirectory;
	}

	private static function get_configPath():String {
		return '$directory/Config.json';
	}
}
