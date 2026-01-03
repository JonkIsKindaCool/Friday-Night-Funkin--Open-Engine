package engine.utils.log;

enum abstract Ansi(String) to String from String {
	var Reset = "\x1b[0m";

	var Black = "\x1b[30m";
	var Red = "\x1b[31m";
	var Green = "\x1b[32m";
	var Yellow = "\x1b[33m";
	var Blue = "\x1b[34m";
	var Magenta = "\x1b[35m";
	var Cyan = "\x1b[36m";
	var White = "\x1b[37m";

	var BrightBlack = "\x1b[90m";
	var BrightRed = "\x1b[91m";
	var BrightGreen = "\x1b[92m";
	var BrightYellow = "\x1b[93m";
	var BrightBlue = "\x1b[94m";
	var BrightMagenta = "\x1b[95m";
	var BrightCyan = "\x1b[96m";
	var BrightWhite = "\x1b[97m";

	var BgBlack = "\x1b[40m";
	var BgRed = "\x1b[41m";
	var BgGreen = "\x1b[42m";
	var BgYellow = "\x1b[43m";
	var BgBlue = "\x1b[44m";
	var BgMagenta = "\x1b[45m";
	var BgCyan = "\x1b[46m";
	var BgWhite = "\x1b[47m";

	var Bold = "\x1b[1m";
	var Dim = "\x1b[2m";
	var Italic = "\x1b[3m";
	var Underline = "\x1b[4m";
	var Blink = "\x1b[5m";
	var Reverse = "\x1b[7m";
	var Hidden = "\x1b[8m";
	var Strikethrough = "\x1b[9m";

	var NoBold = "\x1b[22m";
	var NoDim = "\x1b[22m";
	var NoItalic = "\x1b[23m";
	var NoUnderline = "\x1b[24m";
	var NoBlink = "\x1b[25m";
	var NoReverse = "\x1b[27m";
	var NoStrikethrough = "\x1b[29m";

	var BoldRed = "\x1b[1;31m";
	var BoldGreen = "\x1b[1;32m";
	var BoldYellow = "\x1b[1;33m";
	var BoldBlue = "\x1b[1;34m";

	static public inline function color(fg:Ansi, ?bg:Ansi, ?style:Ansi):String {
		var s = style == null ? "" : style;
		var b = bg == null ? "" : bg;
		return s + fg + b;
	}
}
