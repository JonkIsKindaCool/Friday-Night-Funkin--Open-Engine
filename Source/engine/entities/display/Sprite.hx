package engine.entities.display;

import engine.components.TextureComponent;
import engine.components.TransformComponent;

class Sprite extends Entity {
    public var transform:TransformComponent;
    public var texture:TextureComponent;

    public function new(path:String, x:Float = 0, y:Float = 0) {
        super();
        transform = new TransformComponent(this, x, y);
        texture = new TextureComponent(this, path);
    }
}