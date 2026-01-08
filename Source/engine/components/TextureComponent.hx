package engine.components;

import engine.core.Engine;
import engine.renderer.Renderer;
import lime.math.Matrix4;
import lime.math.Vector2;
import lime.math.Vector4;
import engine.backend.AssetsCache;
import engine.graphics.Texture;

using engine.utils.math.MatrixUtils;

class TextureComponent extends Component {
	private var _texture:Texture;

	public function new(parent:Entity, path:String) {
		super(parent);

		_texture = AssetsCache.cacheImage(path);
	}

	override function render() {
		super.render();
		var pos:Vector2 = (parent.hasComponent(TransformComponent) ? parent.getComponent(TransformComponent).position : new Vector2());
		var scale:Vector2 = (parent.hasComponent(TransformComponent) ? parent.getComponent(TransformComponent).scale : new Vector2(1, 1));
        var rotation:Float = (parent.hasComponent(TransformComponent) ? parent.getComponent(TransformComponent).rotation : 0);
		
        var camera:Camera =  Engine.camera;

		var pivotX:Float = _texture.width * 0.5;
		var pivotY:Float = _texture.height * 0.5;

		var matrix:Matrix4 = new Matrix4();
		matrix.identity();

		MatrixUtils.translate(matrix, pos.x, pos.y);
		MatrixUtils.scale(matrix, scale.x, scale.y);
		MatrixUtils.rotateAround(matrix, pivotX, pivotY, rotation);

        Renderer.renderImage(_texture, matrix, camera);
	}

	override function destroy() {
		super.destroy();
	}
}
