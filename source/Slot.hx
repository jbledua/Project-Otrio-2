import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import haxe.Log;

class Slot extends FlxSprite
{
	private var pieces:FlxTypedGroup<Piece>;

	// Constructor
	public function new(_x:Float = 0, _y:Float = 0)
	{
		Log.trace("In Slot X: " + _x + ", Y: " + _y);

		super(_x, _y);
	}

	public function setPieces(_pieces:FlxTypedGroup<Piece>)
	{
		this.pieces = _pieces;
	}

	public function getCenter()
	{
		// Returns the center point of the player
		return new FlxPoint(this.x + Std.int(this.width / 2), this.y + Std.int(this.height / 2));
	}

	public function create()
	{
		// The default dimensions
		var _width = 50;
		var _height = 50;

		// Replace with Board Graphic
		makeGraphic(_width, _height, FlxColor.CYAN);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.justPressed)
		{
			if (FlxG.mouse.overlaps(this))
			{
				Log.trace("Clicked");
			}
		}
	}
}
