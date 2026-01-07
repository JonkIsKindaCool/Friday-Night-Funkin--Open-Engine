package engine.components;

class GroupComponent extends Component {
    public var members:Array<Entity>;

    public function new(parent:Entity) {
        super(parent);
        members = [];
    }

    public function add(m:Entity) {
        members.push(m);
    }

    public function remove(m:Entity) {
        members.remove(m);
    }

    override function render() {
        super.render();
        for (m in members) m.render();
    }

    override function update(dt:Float) {
        super.update(dt);
        for (m in members) m.update(dt);
    }

    override function destroy() {
        super.destroy();
        for (m in members){
            m.destroy();
        }
    }
}