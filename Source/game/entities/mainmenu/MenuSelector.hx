package game.entities.mainmenu;

import engine.renderer.batch.TextureBatch;
import engine.graphics.Texture;
import engine.core.Engine;
import engine.utils.math.MatrixUtils;
import engine.Camera;
import lime.math.Matrix4;
import lime.math.Vector2;
import engine.backend.AssetsCache;
import engine.animations.FramesGenerator;
import engine.animations.Frame;
import engine.animations.AnimationManager;
import engine.Entity;

class MenuSelector extends Entity {
    public var batcher:TextureBatch;
    public var options:Array<MenuOption>;
    public var onSelect:(MenuOptionType) -> Void;

    private var curSelected(default, set):Int;

    public static var OPTIONS_TEXTURE:Texture;
    
    public function new() {
        super();
        if (OPTIONS_TEXTURE == null)
            OPTIONS_TEXTURE = AssetsCache.cacheImage('assets/images/mainmenu/FNF_main_menu_assets.png');

        batcher = new TextureBatch(10);

        options = [
            new MenuOption(60, STORY_MODE, this),
            new MenuOption(60 + 160, FREEPLAY, this),
            new MenuOption(60 + 160 * 2, OPTIONS, this),
        ];

        curSelected = 0;
    }

    override function update(dt:Float) {
        super.update(dt);
        if (InputSystem.getJustPressed(UP))
            curSelected--;
        else if (InputSystem.getJustPressed(DOWN))
            curSelected++;

        if (InputSystem.getJustPressed(RETURN)){
            if (onSelect != null)
                onSelect(options[curSelected].type);
        }

        for (option in options){
            option.update(dt);
        }
    }

    override function render() {
        super.render();
        batcher.begin(OPTIONS_TEXTURE);
        for (option in options){
            option.render();
        }
        batcher.end();
    }

    private function set_curSelected(i:Int):Int {
        curSelected = Math.floor(Math.min(options.length - 1, Math.max(i, 0)));
        for (i => o in options){
            if (i == curSelected)
                o.animation.playAnimation('selected', true);
            else
                o.animation.playAnimation('idle', true);
        }

        return curSelected;
    }
}

class MenuOption extends Entity{
    public static var OPTIONS_FRAMES:Map<String, Frame>;

    public var animation:AnimationManager;
    public var type:MenuOptionType;
    public var pos:Vector2;
    public var animOffset:Vector2;
    public var parent:MenuSelector;

    public function new(y:Float, type:MenuOptionType, parent:MenuSelector) {
        super();
        this.type = type;

        if (OPTIONS_FRAMES == null)
            OPTIONS_FRAMES = FramesGenerator.fromSparrowAtlas('assets/images/mainmenu/FNF_main_menu_assets.xml');
        
        animation = new AnimationManager(MenuSelector.OPTIONS_TEXTURE, OPTIONS_FRAMES);
        animation.addAnimationByPrefix('idle', type + ' basic', 24);
        animation.addAnimationByPrefix('selected', type + ' white', 24);
        animation.playAnimation('idle');

        pos = new Vector2(0, y);
        animOffset = new Vector2();

        this.parent = parent;
    }

    override function update(dt:Float) {
        super.update(dt);
        animation.update(dt);
    }

    override function render() {
        super.render();
        var frame:Frame = animation.currentAnimation.frames[Math.floor(animation.animationIndex % animation.currentAnimation.frames.length)];
        pos.x = (Engine.designWidth - frame.rect.width) / 2;
        
        this.parent.batcher.drawImage(pos.x - frame.offset.x, pos.y - frame.offset.y, frame.rect.x, frame.rect.y, frame.rect.width, frame.rect.height);
    }
}

enum abstract MenuOptionType(String) to String  {
    var STORY_MODE = "story mode";
    var FREEPLAY = "freeplay";
    var OPTIONS = "options";
}