package engine.core;

import engine.backend.AudioSystem;
import game.scenes.TitleScene;
import engine.Scene;
import lime.app.Event;
import engine.renderer.Renderer;
import lime.graphics.OpenGLES3RenderContext;
import lime.math.Matrix4;
import lime.graphics.WebGLRenderContext;
import haxe.Log;
import lime.graphics.RenderContext;
import lime.app.Application;

class Engine extends Application {
	public static var initialized:Bool = false;
	public static var view:Matrix4 = new Matrix4();
	public static var gl(get, never):OpenGLES3RenderContext;

	public static var designWidth:Int = 1280;
	public static var designHeight:Int = 720;

	public static var currentScene:Scene;

	public function new() {
		super();
		Log.trace = Logger.trace;
	}

	private function start() {
		initialized = true;

		gl.enable(gl.TEXTURE_2D);
		gl.enable(gl.BLEND);

		gl.blendFunc(gl.ONE, gl.ONE_MINUS_SRC_ALPHA);

		Renderer.init();
		AudioSystem.init();

		trace('${Ansi.BrightCyan}Open Engine${Ansi.Reset} Initialized');

		updateLetterbox(window.width, window.height);

		currentScene = new TitleScene();
	}

	private function updateLetterbox(winW:Int, winH:Int):Void {
		var aspectDesign:Float = designWidth / designHeight;
		var aspectWindow:Float = winW / winH;

		var vpX:Int = 0;
		var vpY:Int = 0;
		var vpW:Int = winW;
		var vpH:Int = winH;

		if (aspectWindow > aspectDesign) {
			vpW = Math.round(winH * aspectDesign);
			vpX = Math.round((winW - vpW) / 2);
		} else {
			vpH = Math.round(winW / aspectDesign);
			vpY = Math.round((winH - vpH) / 2);
		}

		gl.viewport(vpX, vpY, vpW, vpH);

		view.createOrtho(0, designWidth, designHeight, 0, -1000, 1000);
	}

	override function onWindowResize(width:Int, height:Int) {
		super.onWindowResize(width, height);
		if (!initialized)
			return;

		updateLetterbox(width, height);
	}

	override function update(deltaTime:Int) {
		super.update(deltaTime);
		if (!initialized)
			return;

		if (currentScene != null)
			currentScene.update(deltaTime / 1000.0);
	}

	override function render(context:RenderContext) {
		super.render(context);

		if (context.type != OPENGL && context.type != OPENGLES)
			throw 'unsopported render context';

		if (!initialized)
			start();

		gl.clearColor(0.0, 0.0, 0.0, 1.0);
		gl.clear(gl.COLOR_BUFFER_BIT);

		if (currentScene != null)
			currentScene.render();
	}

	private static function get_gl():OpenGLES3RenderContext {
		return Application.current.window.context.gl;
	}
}
