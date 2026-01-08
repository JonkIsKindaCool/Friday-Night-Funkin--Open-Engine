package engine.components;

import haxe.ds.StringMap;
import engine.animations.AnimationManager;
import engine.core.Engine;
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
	private var manager:AnimationManager;

	public var flipX:Bool = false;
	public var animOffsets:StringMap<Vector2> = new StringMap();
	public var animationNames:Array<String>;
	public var currentAnimationName:String;

	private var animOffset:Vector2 = new Vector2();

	public function new(parent:Entity, path:String, frames:Map<String, Frame>) {
		super(parent);
		_texture = AssetsCache.cacheImage(path);
		manager = new AnimationManager(_texture, frames);
		animationNames = [];
	}

	public function addAnimationByPrefix(name:String, prefix:String, framerate:Float, ?loop:Bool, ?offset:Vector2) {
		manager.addAnimationByPrefix(name, prefix, framerate, loop);
		animationNames.push(name);
		animOffsets.set(name, offset ?? new Vector2());
	}

	public function addAnimationByIndices(name:String, prefix:String, indices:Array<Int>, framerate:Float, ?loop:Bool, ?offset:Vector2) {
		manager.addAnimationByIndices(name, prefix, indices, framerate, loop);
		animationNames.push(name);
		animOffsets.set(name, offset ?? new Vector2());
	}

	public function playAnimation(name:String, ?force:Bool = true) {
		manager.playAnimation(name, force);
		animOffset = animOffsets.get(name);
		currentAnimationName = name;
	}

	public inline function hasAnimation(n:String) {
		return animationNames.contains(n);
	}

	override function update(dt:Float) {
		super.update(dt);
		manager.update(dt);
	}

	override function render() {
		super.render();

		var frame:Frame = manager.currentAnimation.frames[Math.floor(manager.animationIndex % manager.currentAnimation.frames.length)];

		var pos:Vector2 = parent.hasComponent(TransformComponent) ? parent.getComponent(TransformComponent).position : new Vector2();
		var scale:Vector2 = parent.hasComponent(TransformComponent) ? parent.getComponent(TransformComponent).scale : new Vector2(1, 1);
		var rotation:Float = parent.hasComponent(TransformComponent) ? parent.getComponent(TransformComponent).rotation : 0;

		var camera:Camera = Engine.camera;

		var pivotX = frame.rect.width * 0.5;
		var pivotY = frame.rect.height * 0.5;

		var matrix:Matrix4 = new Matrix4();
		matrix.identity();

		MatrixUtils.translate(matrix, pos.x - frame.offset.x + animOffset.x, pos.y - frame.offset.y + animOffset.y);
		MatrixUtils.scale(matrix, scale.x * (flipX ? -1 : 1), scale.y);
		MatrixUtils.rotateAround(matrix, pivotX, pivotY, rotation);

		Renderer.renderFrame(_texture, frame.rect.clone(), matrix, camera);
	}

	override function destroy() {
		super.destroy();
	}
}
