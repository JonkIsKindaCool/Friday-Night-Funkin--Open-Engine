package engine.entities.group;

import engine.components.GroupComponent;

class Group extends Entity{
    public var group:GroupComponent;

    public function new() {
        super();
        group = new GroupComponent(this);
    }

    public function add(m:Entity) {
        group.add(m);
    }

    public function remove(m:Entity) {
        group.remove(m);
    }
}