package engine.utils.math;

import lime.math.Matrix4;

class MatrixUtils {
	public static function setRotation(matrix:Matrix4, radians:Float):Void {
		var cos:Float = Math.cos(radians);
		var sin:Float = Math.sin(radians);

		var sx:Float = Math.sqrt(matrix[0] * matrix[0] + matrix[1] * matrix[1]);
		var sy:Float = Math.sqrt(matrix[4] * matrix[4] + matrix[5] * matrix[5]);

		matrix[0] = cos * sx;
		matrix[1] = sin * sx;
		matrix[4] = -sin * sy;
		matrix[5] = cos * sy;
	}

	public static function setScale(matrix:Matrix4, sx:Float, sy:Float):Void {
		var m00:Float = matrix[0];
		var m01:Float = matrix[1];
		var m10:Float = matrix[4];
		var m11:Float = matrix[5];

		var lenX:Float = Math.sqrt(m00 * m00 + m01 * m01);
		var lenY:Float = Math.sqrt(m10 * m10 + m11 * m11);

		if (lenX > 0) {
			matrix[0] = m00 / lenX * sx;
			matrix[1] = m01 / lenX * sx;
		} else {
			matrix[0] = sx;
			matrix[1] = 0;
		}

		if (lenY > 0) {
			matrix[4] = m10 / lenY * sy;
			matrix[5] = m11 / lenY * sy;
		} else {
			matrix[4] = 0;
			matrix[5] = sy;
		}
	}

	public static function rotate(matrix:Matrix4, radians:Float) {
		var cos:Float = Math.cos(radians);
		var sin:Float = Math.sin(radians);
		var m00:Float = matrix[0];
		var m01:Float = matrix[1];
		var m10:Float = matrix[4];
		var m11:Float = matrix[5];
		var tx:Float = matrix[12];
		var ty:Float = matrix[13];

		matrix[0] = m00 * cos - m01 * sin;
		matrix[1] = m00 * sin + m01 * cos;
		matrix[4] = m10 * cos - m11 * sin;
		matrix[5] = m10 * sin + m11 * cos;
		matrix[12] = tx * cos - ty * sin;
		matrix[13] = tx * sin + ty * cos;
	}

	public static function rotateAround(matrix:Matrix4, pivotX:Float, pivotY:Float, radians:Float) {
		translate(matrix, -pivotX, -pivotY);
		rotate(matrix, radians);
		translate(matrix, pivotX, pivotY);
	}

	public static function moveTo(matrix:Matrix4, x:Float, y:Float) {
		matrix[12] = x;
		matrix[13] = y;
	}

	public static function translate(matrix:Matrix4, x:Float, y:Float) {
		matrix[12] += x;
		matrix[13] += y;
	}

	public static function scale(matrix:Matrix4, sx:Float, sy:Float) {
		matrix[0] *= sx;
		matrix[1] *= sx;
		matrix[4] *= sy;
		matrix[5] *= sy;
		matrix[12] *= sx;
		matrix[13] *= sy;
	}

	public static function multiply(a:Matrix4, b:Matrix4):Matrix4 {
		var r = new Matrix4();

		r[0] = a[0] * b[0] + a[4] * b[1] + a[8] * b[2] + a[12] * b[3];
		r[1] = a[1] * b[0] + a[5] * b[1] + a[9] * b[2] + a[13] * b[3];
		r[2] = a[2] * b[0] + a[6] * b[1] + a[10] * b[2] + a[14] * b[3];
		r[3] = a[3] * b[0] + a[7] * b[1] + a[11] * b[2] + a[15] * b[3];

		r[4] = a[0] * b[4] + a[4] * b[5] + a[8] * b[6] + a[12] * b[7];
		r[5] = a[1] * b[4] + a[5] * b[5] + a[9] * b[6] + a[13] * b[7];
		r[6] = a[2] * b[4] + a[6] * b[5] + a[10] * b[6] + a[14] * b[7];
		r[7] = a[3] * b[4] + a[7] * b[5] + a[11] * b[6] + a[15] * b[7];

		r[8] = a[0] * b[8] + a[4] * b[9] + a[8] * b[10] + a[12] * b[11];
		r[9] = a[1] * b[8] + a[5] * b[9] + a[9] * b[10] + a[13] * b[11];
		r[10] = a[2] * b[8] + a[6] * b[9] + a[10] * b[10] + a[14] * b[11];
		r[11] = a[3] * b[8] + a[7] * b[9] + a[11] * b[10] + a[15] * b[11];

		r[12] = a[0] * b[12] + a[4] * b[13] + a[8] * b[14] + a[12] * b[15];
		r[13] = a[1] * b[12] + a[5] * b[13] + a[9] * b[14] + a[13] * b[15];
		r[14] = a[2] * b[12] + a[6] * b[13] + a[10] * b[14] + a[14] * b[15];
		r[15] = a[3] * b[12] + a[7] * b[13] + a[11] * b[14] + a[15] * b[15];

		return r;
	}
}
