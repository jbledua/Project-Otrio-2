import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import haxe.Log;

class Piece extends FlxSprite
{
	private var slots:FlxTypedGroup<Slot>; // Global Group of all Slots
	private var parent:Slot;

	private var pieceSize:Int = 1;
	private var pieceColor:FlxColor = FlxColor.WHITE;

	private var pickedUp:Bool = false;
	private var locked:Bool = false;

	public static inline var SMALL:Int = 0;
	public static inline var MEDIUM:Int = 1;
	public static inline var LARGE:Int = 2;

	// Constructor
	public function new(_x:Float = 0, _y:Float = 0)
	{
		super(_x, _y);
	}

	public function setParent(_parent:Slot)
	{
		this.parent = _parent;
	}

	public function setSlots(_slots:FlxTypedGroup<Slot>)
	{
		this.slots = _slots;
	}

	override public function setPosition(x:Float = 0.0, y:Float = 0.0)
	{
		super.setPosition(x - this.width / 2, y - this.height / 2);
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

	public function isPickedup()
	{
		return this.pickedUp;
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
		// Move Piece to Point
		FlxTween.tween(this, {x: _point.x - Std.int(width / 2), y: _point.y - Std.int(height / 2)}, 0.5);
	}

	public function onClicked()
	{
		Log.trace("Clicked");

		this.pickedUp = true;
	}

	public function onDroped()
	{
		Log.trace("Dropped");

		this.pickedUp = false;

		for (i in 0...this.slots.length)
		{
			if (this.overlaps(this.slots.members[i]))
			{
				// Check if the slot has space for the piece
				if (this.slots.members[i].hasSpace(this.getPiecesSize()))
				{
					this.moveTo(this.slots.members[i].getCenter());
				}
				else
				{
					Log.trace("Error: Slot is full");
				}
			}
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (this.isPickedup())
		{
			this.setPosition(FlxG.mouse.getPosition().x, FlxG.mouse.getPosition().y);
		}

		// if (((FlxG.mouse.justPressed) && FlxG.mouse.overlaps(this)) && (!this.locked))
		// {
		// 	Log.trace("Clicked");
		// }
	}
}
