package engine.entities.display;

import engine.components.AnimationComponent;
import engine.animations.Frame;
import engine.components.TextureComponent;
import engine.components.TransformComponent;

class AnimatedSprite extends Entity {
    public var transform:TransformComponent;
    public var animation:AnimationComponent;

    public function new(path:String, frames:Map<String, Frame>, x:Float = 0, y:Float = 0) {
        super();
        transform = new TransformComponent(this, x, y);
        animation = new AnimationComponent(this, path, frames);
    }
}