package engine.components;

import lime.math.Matrix3;
import lime.math.Rectangle;
import engine.renderer.Renderer;
import lime.math.Vector4;
import lime.math.Matrix4;
import lime.math.Vector2;
import engine.animations.Animation;
import engine.backend.AssetsCache;
import engine.graphics.Texture;
import engine.animations.Frame;

using engine.utils.math.MatrixUtils;
using StringTools;

class AnimationComponent extends Component {
	private var _texture:Texture;
	private var _frames:Map<String, Frame>;
	private var _animations:Map<String, Animation>;

	private var animationIndex:Float = 0;
	private var currentAnimation:Animation;

	public function new(parent:Entity, path:String, frames:Map<String, Frame>) {
		super(parent);
		_texture = AssetsCache.cacheImage(path);

		_frames = frames;
		_animations = new Map();
		currentAnimation = {
			frames: [
				{
					rect: new Rectangle(0, 0, _texture.width, _texture.height),
					offset: new Vector2(0, 0)
				}
			],
			framerate: 1
		}

		_animations.set('__default__', currentAnimation);
	}

	public function addAnimationByPrefix(name:String, prefix:String, framerate:Float) {
		var frames:Array<Frame> = [];
		for (k => v in _frames) {
			if (k.startsWith(prefix)) {
				frames.push(v);
			}
		}

		_animations.set(name, {
			framerate: framerate,
			frames: frames
		});
	}

	public function playAnimation(name:String) {
		currentAnimation = _animations.get(name);
	}

	override function update(dt:Float) {
		super.update(dt);
		animationIndex += dt * currentAnimation.framerate;

		if (animationIndex >= currentAnimation.frames.length)
			animationIndex = 0;
	}

	override function render() {
		super.render();

		var frame:Frame = currentAnimation.frames[Math.floor(animationIndex % currentAnimation.frames.length)];

		var pos:Vector2 = parent.hasComponent(TransformComponent) ? parent.getComponent(TransformComponent).position : new Vector2();
		var scale:Vector2 = parent.hasComponent(TransformComponent) ? parent.getComponent(TransformComponent).scale : new Vector2(1, 1);
		var rotation:Float = parent.hasComponent(TransformComponent) ? parent.getComponent(TransformComponent).rotation : 0;

		var pivotX = frame.rect.width * 0.5;
		var pivotY = frame.rect.height * 0.5;

		var matrix:Matrix4 = new Matrix4();
		matrix.identity();

		MatrixUtils.translate(matrix, pos.x - frame.offset.x, pos.y - frame.offset.y);
		MatrixUtils.scale(matrix, scale.x, scale.y);
		MatrixUtils.rotateAround(matrix, pivotX, pivotY, rotation);

		Renderer.renderFrame(_texture, frame.rect.clone(), matrix);
	}
}
