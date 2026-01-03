package engine;

import lime.math.Matrix4;
import engine.utils.math.MatrixUtils;

class Camera {
	public var matrix:Matrix4;

	public var x(get, set):Float;
	public var y(get, set):Float;
	public var rotation(get, set):Float;
	public var zoom(get, set):Float;

	private var _rotation:Float = 0;
	private var _zoom:Float = 1;

	public function new() {
		matrix = new Matrix4();
		matrix.create2D(1, 0, 0, 1, 0, 0);
	}

	function get_x()
		return matrix[12];

	function get_y()
		return matrix[13];

	function set_x(v:Float)
		return matrix[12] = v;

	function set_y(v:Float)
		return matrix[13] = v;

	function get_rotation()
		return _rotation;

	function set_rotation(v:Float):Float {
		_rotation = v;
		MatrixUtils.setRotation(matrix, v);
		return v;
	}

	function get_zoom()
		return _zoom;

	function set_zoom(v:Float):Float {
		_zoom = v;
		MatrixUtils.setScale(matrix, 1 / v, 1 / v);
		return v;
	}

	public function getView():Matrix4 {
		var view = matrix.clone();
		view.invert();
		return view;
	}
}
