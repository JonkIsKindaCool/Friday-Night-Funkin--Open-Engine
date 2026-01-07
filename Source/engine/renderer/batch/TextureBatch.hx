package engine.renderer.batch;

import engine.core.Engine;
import lime.utils.Float32Array;
import engine.utils.UV;
import lime.math.Vector2;
import lime.graphics.opengl.GLBuffer;
import engine.graphics.Shader;
import engine.graphics.Texture;

class TextureBatch {
	public var max_elements:Int;

	private var _currentTexture:Texture;
	private var _shader:Shader;
	private var _buffer:GLBuffer;
	private var vertexData:Float32Array;
	private var dataIndex:Int = 0;
	private var vertexCount:Int = 0;

	static inline var FLOATS_PER_SPRITE = 16;

	public function new(?MAX_ELEMENTS:Int = 10000) {
		max_elements = MAX_ELEMENTS;
		_shader = new Shader('assets/shaders/default/batch_texture.vert', 'assets/shaders/default/batch_texture.frag');

		vertexData = new Float32Array(max_elements * FLOATS_PER_SPRITE);

		_buffer = gl.createBuffer();
		gl.bindBuffer(gl.ARRAY_BUFFER, _buffer);
		gl.bufferData(gl.ARRAY_BUFFER, vertexData.length * Float32Array.BYTES_PER_ELEMENT, new Float32Array([]), gl.DYNAMIC_DRAW);

		gl.enableVertexAttribArray(0);
		gl.vertexAttribPointer(0, 2, gl.FLOAT, false, 4 * Float32Array.BYTES_PER_ELEMENT, 0);
		gl.enableVertexAttribArray(1);
		gl.vertexAttribPointer(1, 2, gl.FLOAT, false, 4 * Float32Array.BYTES_PER_ELEMENT, 2 * Float32Array.BYTES_PER_ELEMENT);
		gl.bindBuffer(gl.ARRAY_BUFFER, null);
	}

	public function begin(t:Texture) {
		if (_currentTexture != t && _currentTexture != null)
			flush();
		_currentTexture = t;
		dataIndex = 0;
		vertexCount = 0;
	}

	public function drawImage(x:Float, y:Float, ?srcX:Float = 0, ?srcY:Float = 0, ?srcW:Float, ?srcH:Float) {
		if (dataIndex / FLOATS_PER_SPRITE >= max_elements - 1)
			flush();

		srcW = srcW == null ? _currentTexture.width : srcW;
		srcH = srcH == null ? _currentTexture.height : srcH;

		final u1 = srcX / _currentTexture.width, v1 = srcY / _currentTexture.height;
		final u2 = (srcX + srcW) / _currentTexture.width, v2 = (srcY + srcH) / _currentTexture.height;
		final idx = dataIndex;

		vertexData[idx + 0] = x;
		vertexData[idx + 1] = y;
		vertexData[idx + 2] = u1;
		vertexData[idx + 3] = v1;
		vertexData[idx + 4] = x;
		vertexData[idx + 5] = y + srcH;
		vertexData[idx + 6] = u1;
		vertexData[idx + 7] = v2;
		vertexData[idx + 8] = x + srcW;
		vertexData[idx + 9] = y;
		vertexData[idx + 10] = u2;
		vertexData[idx + 11] = v1;
		vertexData[idx + 12] = x + srcW;
		vertexData[idx + 13] = y + srcH;
		vertexData[idx + 14] = u2;
		vertexData[idx + 15] = v2;

		dataIndex += FLOATS_PER_SPRITE;
		vertexCount += 4;
	}

	public function flush() {
		if (dataIndex == 0)
			return;
		_shader.activate();
		_shader.setMatrix4('view', Engine.currentScene.camera.getView());
		_currentTexture.activate();
		gl.bindBuffer(gl.ARRAY_BUFFER, _buffer);

		gl.vertexAttribPointer(0, 2, gl.FLOAT, false, 4 * Float32Array.BYTES_PER_ELEMENT, 0);
		gl.enableVertexAttribArray(0);

		gl.vertexAttribPointer(1, 2, gl.FLOAT, false, 4 * Float32Array.BYTES_PER_ELEMENT, 2 * Float32Array.BYTES_PER_ELEMENT);
		gl.enableVertexAttribArray(1);

		gl.bufferSubData(gl.ARRAY_BUFFER, 0, dataIndex * Float32Array.BYTES_PER_ELEMENT, vertexData);
		gl.drawArrays(gl.TRIANGLE_STRIP, 0, vertexCount);
		gl.bindBuffer(gl.ARRAY_BUFFER, null);
		_shader.deactivate();
		dataIndex = 0;
		vertexCount = 0;
	}

	public function end() {
		flush();
		_currentTexture = null;
	}
}
