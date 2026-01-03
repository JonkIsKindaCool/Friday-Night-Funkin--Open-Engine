package engine.components;

import lime.math.Vector2;

class TransformComponent extends Component {
    public var position:Vector2;
    public var scale:Vector2;
    public var rotation:Float;

    public function new(parent:Entity, ?x:Float = 0, ?y:Float = 0) {
        super(parent);
        position = new Vector2(x, y);
        scale = new Vector2(1, 1);
        rotation = 0;
    }
}