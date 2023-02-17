import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import haxe.Log;

class Piece extends FlxSprite
{
	private var pieceSize:Int = 1;
	private var pieceColor:FlxColor = FlxColor.WHITE;

	// Constructor
	public function new(_x:Float = 0, _y:Float = 0)
	{
		super(_x, _y);
	}

	public function setPiecesSize(_pieceSize:Int)
	{
		this.pieceSize = _pieceSize;
	}

	public function getPiecesSize():Int
	{
		return this.pieceSize;
	}

	public function setPiecesColor(_color:FlxColor)
	{
		this.pieceColor = _color;
	}

	public function getPiecesColor(_color:FlxColor)
	{
		return this.pieceColor;
	}

	public function create()
	{
		var _pieceSize:Int;

		switch this.pieceSize
		{
			case 0:
				// Replace with small size sprite
				_pieceSize = 10;
				makeGraphic(_pieceSize, _pieceSize, this.pieceColor);
			case 1:
				// Replace with medium size sprite
				_pieceSize = 30;
				makeGraphic(_pieceSize, _pieceSize, this.pieceColor);
			case 2:
				// Replace with large size sprite
				_pieceSize = 50;
				makeGraphic(_pieceSize, _pieceSize, this.pieceColor);
			default:
				// Replace with medium size sprite
				_pieceSize = 30;
				makeGraphic(_pieceSize, _pieceSize, this.pieceColor);
		} // End Switch
	} // End Create

	public function moveTo(_point:FlxPoint)
	{
		Log.trace("Move to " + Std.string(_point.x) + "," + Std.string(_point.y));

		// Move Piece to Point
		FlxTween.tween(this, {x: _point.x - Std.int(width / 2), y: _point.y - Std.int(height / 2)}, 0.5);
	}
}
