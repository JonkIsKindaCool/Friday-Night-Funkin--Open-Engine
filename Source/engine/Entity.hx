package engine;

import lime.app.Event;
import haxe.ds.StringMap;

class Entity {
	public var components:StringMap<Component>;

	public var onUpdate:Event<Float->Void>;
	public var onRender:Event<Void->Void>;

	public function new() {
		components = new StringMap<Component>();

		onUpdate = new Event<Float->Void>();
		onRender = new Event<Void->Void>();
	}

	public function update(dt:Float) {
		onUpdate.dispatch(dt);
	}

	public function render() {
		onRender.dispatch();
	}

	public function addComponent(c:Component):Void {
		var name = Type.getClassName(Type.getClass(c));

		if (components.exists(name))
			return;

		onUpdate.add(c.update);
		onRender.add(c.render);
		components.set(name, c);
	}

	public function hasComponent(c:Class<Component>):Bool {
		return components.exists(Type.getClassName(c));
	}

	public function getComponent<T:Component>(c:Class<T>):T {
		var comp = components.get(Type.getClassName(c));
		return cast comp;
	}

	public function removeComponent(c:Class<Component>):Void {
		var name = Type.getClassName(c);
		if (components.exists(name)) {
			var comp:Component = components.get(name);

			onUpdate.remove(comp.update);
			onRender.remove(comp.render);

			components.remove(name);
		}
	}
}
