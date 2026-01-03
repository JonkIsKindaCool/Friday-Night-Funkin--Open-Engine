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
			var frame:Frame = {
				rect: new Rectangle(Std.parseFloat(element.get('x')), Std.parseFloat(element.get('y')), Std.parseFloat(element.get('width')),
					Std.parseFloat(element.get('height'))),
                offset: new Vector2(Std.parseFloat(element.get('frameX')), Std.parseFloat(element.get('frameY')))
			}
			frames.set(element.get('name'), frame);
		}

		return frames;
	}
}
