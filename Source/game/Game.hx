package game;

import engine.backend.SaveSystem;
import engine.backend.AudioSystem;
import haxe.Json;
import sys.io.File;
import sys.FileSystem;
import game.backend.Conductor;
import engine.backend.AssetsCache;
import lime.utils.Assets;
import engine.entities.group.Group;
import game.scenes.TitleScene;
import engine.Scene;
import engine.Entity;

class Game extends Entity {
	public static var currentScene:Scene;

	public function new() {
		super();

		AudioSystem.volume = SaveSystem.data.volume;

		AudioSystem.onVolumeChange.add(v -> {
            SaveSystem.saveData('volume', v);
		});

		Conductor.init();
		Conductor.loadSong('assets/music/freakyMenu.ogg', 102);

		changeScene(new TitleScene());
	}

	override function update(dt:Float) {
		super.update(dt);
		currentScene.update(dt);
	}

	override function render() {
		super.render();
		currentScene.render();
	}

	override function destroy() {
		super.destroy();
		currentScene.destroy();
	}

	public static function changeScene(scene:Scene) {
		if (currentScene != null)
			currentScene.destroy();

		currentScene = scene;
		scene.create();
	}
}
