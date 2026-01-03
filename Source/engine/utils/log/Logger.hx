package engine.utils.log;

import haxe.Log;
import haxe.PosInfos;

using StringTools;

enum abstract Level(String) from String to String {
	var TRACE = "[TRACE]";
	var DEBUG = "[DEBUG]";
	var INFO = "[INFO ]";
	var WARN = "[WARN ]";
	var ERROR = "[ERROR]";
	var FATAL = "[FATAL]";
}

class Logger {
	private static inline var TEMPLATE = "{time} {level} {location} {message}";

	private static function getLevelColor(level:Level):Ansi {
		return switch level {
			case TRACE: Ansi.BrightBlack;
			case DEBUG: Ansi.BrightCyan;
			case INFO: Ansi.BrightGreen;
			case WARN: Ansi.BrightYellow;
			case ERROR: Ansi.BrightRed;
			case FATAL: Ansi.Bold;
		}
	}

	private static inline function formatTime():String {
		final now:Date = Date.now();

		final h:String = Std.string(now.getHours()).lpad("0", 2);
		final m:String =  Std.string(now.getMinutes()).lpad("0", 2);
		final s:String =  Std.string(now.getSeconds()).lpad("0", 2);

		return '$h:$m:$s';
	}

	private static function formatLocation(infos:PosInfos):String {
		final cls:String = infos.className;
		final method:String = infos.methodName == "new" ? "constructor" : infos.methodName;

		return '${cls}.${method}:${infos.lineNumber}';
	}

	public static function log(msg:Dynamic, level:Level = INFO, ?pos:PosInfos):Void {
		final time:String = formatTime();
		final color:String = getLevelColor(level);
		final reset:String = Ansi.Reset;
		final levelStr:String = color + level + reset;
		final location:String = formatLocation(pos);

		var output = TEMPLATE.replace("{time}", '[${time}]')
			.replace("{level}", levelStr)
			.replace("{location}", '[$location]')
			.replace("{message}", Std.string(msg));

		println(output + Ansi.Reset);
	}

	public static inline function trace(v:Dynamic, ?pos:PosInfos)
		log(v, TRACE, pos);

	public static inline function debug(v:Dynamic, ?pos:PosInfos)
		log(v, DEBUG, pos);

	public static inline function info(v:Dynamic, ?pos:PosInfos)
		log(v, INFO, pos);

	public static inline function warn(v:Dynamic, ?pos:PosInfos)
		log(v, WARN, pos);

	public static inline function error(v:Dynamic, ?pos:PosInfos)
		log(v, ERROR, pos);

	public static inline function fatal(v:Dynamic, ?pos:PosInfos)
		log(v, FATAL, pos);

	public static function println(msg:Dynamic):Void {
		#if sys
		Sys.println(msg);
		#elseif js
		js.Syntax.code("console.log({0})", msg);
		#else
		trace(msg);
		#end
	}
}
