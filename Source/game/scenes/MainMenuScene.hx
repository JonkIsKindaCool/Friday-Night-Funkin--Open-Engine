package game.scenes;

import game.entities.mainmenu.MenuSelector;
import engine.entities.display.Sprite;

class MainMenuScene extends MusicScene {
	var bg:Sprite;
	var selector:MenuSelector;

	public function new() {
		super();
	}

	override function create() {
		super.create();
		bg = new Sprite("assets/images/menuBG.png");
		add(bg);

		selector = new MenuSelector();
		selector.onSelect = onSelect;
		add(selector);
	}

	function onSelect(t:MenuOptionType) {
		trace(t);	
	}

	override function update(dt:Float) {
		super.update(dt);
		if (InputSystem.getJustPressed(ESCAPE))
			Game.changeScene(new TitleScene());
	}
}
