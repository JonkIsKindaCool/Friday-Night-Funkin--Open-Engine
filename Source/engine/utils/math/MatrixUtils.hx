package engine.utils.math;

import lime.math.Matrix4;

class MatrixUtils {
	public static function rotate(matrix:Matrix4, radians:Float):Void {
		var cos = Math.cos(radians);
		var sin = Math.sin(radians);

		var m00 = matrix[0];
		var m01 = matrix[1];
		var m10 = matrix[4];
		var m11 = matrix[5];
		var tx = matrix[12];
		var ty = matrix[13];

		matrix[0] = m00 * cos - m01 * sin;
		matrix[1] = m00 * sin + m01 * cos;
		matrix[4] = m10 * cos - m11 * sin;
		matrix[5] = m10 * sin + m11 * cos;

		matrix[12] = tx * cos - ty * sin;
		matrix[13] = tx * sin + ty * cos;
	}

	public static function rotateAround(matrix:Matrix4, pivotX:Float, pivotY:Float, radians:Float):Void {
		translate(matrix, -pivotX, -pivotY);
		rotate(matrix, radians);
		translate(matrix, pivotX, pivotY);
	}

	public static function translate(matrix:Matrix4, x:Float, y:Float):Void {
		matrix[12] += x;
		matrix[13] += y;
	}

	public static function scale(matrix:Matrix4, sx:Float, sy:Float):Void {
		matrix[0] *= sx;
		matrix[1] *= sx;
		matrix[4] *= sy;
		matrix[5] *= sy;
		matrix[12] *= sx;
		matrix[13] *= sy;
	}
}