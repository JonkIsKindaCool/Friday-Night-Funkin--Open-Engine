package game.scenes;

import engine.Scene;
import engine.audio.Sound;
import engine.entities.display.AnimatedSprite;
import engine.animations.FramesGenerator;
import engine.entities.display.Sprite;

class TitleScene extends Scene {
	private var titleMusic:Sound; 
    private var s:AnimatedSprite;

	public function new() {
		super();

		s = new AnimatedSprite('assets/images/characters/BOYFRIEND.png',
			FramesGenerator.fromSparrowAtlas('assets/images/characters/BOYFRIEND.xml'), -100);
		s.animation.addAnimationByPrefix('idle', 'BF idle dance', 24);
		s.animation.playAnimation('idle');
		add(s);

		titleMusic = new Sound('assets/music/tes.ogg'); 
	}

    override function update(dt:Float) {
        super.update(dt);
        s.transform.rotation += dt * 10;
    }
}
