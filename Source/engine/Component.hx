package engine;

class Component {
	public var parent:Entity;

	public function new(parent:Entity) {
		this.parent = parent;
		parent.addComponent(this);
	}

	public function update(dt:Float) {}

	public function render() {}
}
