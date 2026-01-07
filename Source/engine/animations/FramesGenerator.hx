package engine.animations;

import lime.math.Vector2;
import lime.math.Rectangle;
import sys.io.File;

class FramesGenerator {
	public static function fromSparrowAtlas(path:String) {
		var content:String = File.getContent(path);
		var frames:Map<String, Frame> = new Map();

		var xml:Xml = Xml.parse(content).firstElement();
		for (element in xml.elementsNamed('SubTexture')) {
			var x:Float = Std.parseFloat(element.get('x'));
			var y:Float = Std.parseFloat(element.get('y'));
			var width:Float = Std.parseFloat(element.get('width'));
			var height:Float = Std.parseFloat(element.get('height'));

			var frameXAttr:String = element.get('frameX');
			var frameYAttr:String = element.get('frameY');
			var offsetX:Float = (frameXAttr != null) ? Std.parseFloat(frameXAttr) : 0;
			var offsetY:Float = (frameYAttr != null) ? Std.parseFloat(frameYAttr) : 0;

			var frame:Frame = {
				rect: new Rectangle(x, y, width, height),
				offset: new Vector2(offsetX, offsetY)
			}
			frames.set(element.get('name'), frame);
		}

		return frames;
	}
}
