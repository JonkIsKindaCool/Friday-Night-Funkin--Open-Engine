package game.scenes;

import engine.core.Engine;
import lime.math.Vector2;
import game.objects.FunkinSprite;
import game.backend.Conductor;
import engine.backend.AssetsCache;
import engine.graphics.Texture;
import engine.renderer.batch.TextureBatch;
import engine.utils.Color;
import engine.Scene;
import engine.audio.Sound;
import engine.entities.display.AnimatedSprite;
import engine.animations.FramesGenerator;
import engine.entities.display.Sprite;

class TitleScene extends MusicScene {
	private var gf:FunkinSprite;
	private var logo:FunkinSprite;
	private var titleText:FunkinSprite;

	public function new() {
		Conductor.init();
		super();

		Conductor.loadSong('assets/music/freakyMenu.ogg', 102);

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
}
