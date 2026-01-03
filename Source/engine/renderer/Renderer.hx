package engine.renderer;

import engine.utils.UV;
import lime.math.Vector2;
import lime.math.Rectangle;
import lime.utils.Float32Array;
import lime.graphics.opengl.GLBuffer;
import engine.graphics.Shader;
import engine.backend.AssetsCache;
import engine.graphics.Texture;
import lime.math.Matrix4;

class Renderer {
	private static var _textureShader:Shader;
	private static var _buffer:GLBuffer;

	@:noCompletion
	public static function init() {
		_textureShader = new Shader('assets/shaders/default/default_texture.vert', 'assets/shaders/default/default_texture.frag');
		_buffer = gl.createBuffer();
	}

	public static function renderFrame(texture:Texture, frame:Rectangle, matrix:Matrix4) {
		_textureShader.activate();
		_textureShader.setMatrix4('model', matrix);
		texture.activate();

		gl.bindBuffer(gl.ARRAY_BUFFER, _buffer);

		final uvTopLeft:Vector2 = UV.coordinatesToUv(frame.x, frame.y, texture.width, texture.height);
		final uvBottomRight:Vector2 = UV.coordinatesToUv(frame.x + frame.width, frame.y + frame.height, texture.width, texture.height);

		final data:Array<Float> = [
			          0,            0,     uvTopLeft.x,     uvTopLeft.y,
			          0, frame.height,     uvTopLeft.x, uvBottomRight.y,
			frame.width,            0, uvBottomRight.x,     uvTopLeft.y,
			frame.width, frame.height, uvBottomRight.x, uvBottomRight.y
		];

		gl.bufferData(gl.ARRAY_BUFFER, Float32Array.BYTES_PER_ELEMENT * data.length, new Float32Array(data), gl.STATIC_DRAW);

		gl.vertexAttribPointer(0, 2, gl.FLOAT, false, 4 * Float32Array.BYTES_PER_ELEMENT, 0);
		gl.enableVertexAttribArray(0);

		gl.vertexAttribPointer(1, 2, gl.FLOAT, false, 4 * Float32Array.BYTES_PER_ELEMENT, 2 * Float32Array.BYTES_PER_ELEMENT);
		gl.enableVertexAttribArray(1);

		gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);

		gl.bindBuffer(gl.ARRAY_BUFFER, null);
		_textureShader.deactivate();
	}

	public static function renderImage(texture:Texture, matrix:Matrix4) {
		_textureShader.activate();
		_textureShader.setMatrix4('model', matrix);
		texture.activate();

		gl.bindBuffer(gl.ARRAY_BUFFER, _buffer);

		final data:Array<Float> = [
			            0,              0, 0, 0,
			            0, texture.height, 0, 1,
			texture.width,              0, 1, 0,
			texture.width, texture.height, 1, 1
		];

		gl.bufferData(gl.ARRAY_BUFFER, Float32Array.BYTES_PER_ELEMENT * data.length, new Float32Array(data), gl.STATIC_DRAW);

		gl.vertexAttribPointer(0, 2, gl.FLOAT, false, 4 * Float32Array.BYTES_PER_ELEMENT, 0);
		gl.enableVertexAttribArray(0);

		gl.vertexAttribPointer(1, 2, gl.FLOAT, false, 4 * Float32Array.BYTES_PER_ELEMENT, 2 * Float32Array.BYTES_PER_ELEMENT);
		gl.enableVertexAttribArray(1);

		gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);

		gl.bindBuffer(gl.ARRAY_BUFFER, null);
		_textureShader.deactivate();
	}
}
