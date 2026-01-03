package engine.graphics;

import lime.graphics.opengl.GLTexture;
import lime.graphics.Image;

class Texture {
	public var glTexture:GLTexture;

	public var width:Int;
	public var height:Int;

	public function new(path:String) {
		var img:Image = Image.fromFile('$path');

		width = img.width;
		height = img.height;

		glTexture = gl.createTexture();
		gl.bindTexture(gl.TEXTURE_2D, glTexture);

		img.format = RGBA32;
		img.premultiplied = false;

		gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, img.width, img.height, 0, gl.RGBA, gl.UNSIGNED_BYTE, img.data);
		gl.generateMipmap(gl.TEXTURE_2D);

		img = null;
	}

	public function activate() {
		gl.bindTexture(gl.TEXTURE_2D, glTexture);
	}

	public function destroy() {
		gl.deleteTexture(glTexture);
	}
}
