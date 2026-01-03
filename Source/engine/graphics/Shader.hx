package engine.graphics;

import lime.utils.Float32Array;
import engine.core.Engine;
import lime.math.Matrix4;
import sys.io.File;
import lime.graphics.opengl.GLProgram;

class Shader {
    public var program:GLProgram;

    public function new(vertexPath:String, fragmentPath:String) {
        program = GLProgram.fromSources(gl, File.getContent('$vertexPath'), File.getContent('$fragmentPath'));
    }

    public function activate() {
        gl.useProgram(program);
        setMatrix4('view', Engine.view);
    }

    public inline function deactivate() 
        gl.useProgram(null);

    public inline function setMatrix4(name:String, m:Matrix4) 
        gl.uniformMatrix4fv(gl.getUniformLocation(program, name), 1, false, m);

    public inline function getAttribLocation(name:String)
        return gl.getAttribLocation(program, name);

    public inline function destroy() 
        gl.deleteProgram(program);
}