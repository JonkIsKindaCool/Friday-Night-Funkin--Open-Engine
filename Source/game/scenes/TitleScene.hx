package game.scenes;

import engine.core.Engine;
import lime.math.Vector2;
import game.entities.FunkinSprite;

class TitleScene extends MusicScene {
	private var gf:FunkinSprite;
	private var logo:FunkinSprite;
	private var titleText:FunkinSprite;

	public function new() {
		super();
	}

	override function create() {
		super.create();

		gf = new FunkinSprite(Engine.designWidth * 0.4, Engine.designHeight * 0.07, 'assets/images/titlestate/gfDanceTitle', SPARROW);
		gf.addAnimationByIndices('danceLeft', 'gfDance', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], 24, new Vector2());
		gf.addAnimationByIndices('danceRight', 'gfDance', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], 24, new Vector2());
		gf.dance();
		add(gf);

		logo = new FunkinSprite(-150, -100, 'assets/images/titlestate/logoBumpin', SPARROW);
		logo.addAnimationByPrefix('idle', 'logo bumpin', 24, new Vector2());
		logo.dance();
		add(logo);

		titleText = new FunkinSprite(100, Engine.designHeight * 0.8, 'assets/images/titlestate/titleEnter', SPARROW);
		titleText.addAnimationByPrefix('start', "Press Enter to Begin", 24, new Vector2());
		titleText.addAnimationByPrefix('press', "ENTER PRESSED", 24, new Vector2());
		titleText.playAnimation('start');
		add(titleText);
	}
	
	override function update(dt:Float) {
		super.update(dt);
		if (InputSystem.getJustPressed(RETURN))
			Game.changeScene(new MainMenuScene());
	}
}
