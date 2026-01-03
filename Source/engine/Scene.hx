package engine;

import engine.entities.group.Group;

class Scene extends Group {
    public var camera:Camera;

    public function new() {
        camera = new Camera();
        super();
    }
}
