import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import haxe.Log;

class Slot extends FlxSprite
{
	// Global Groups
	private var slots:FlxTypedGroup<Slot>; // Global Group of all Slots
	private var pieces:FlxTypedGroup<Piece>; // Global Group of all Pieces

	// Local Pieces
	private var parent:Player;
	private var slotPieces:FlxTypedGroup<Piece>; // Local Group of Pieces that are created by the slot

	private var colorLight:FlxColor = FlxColor.fromHSB(0, 0, 1, 1);
	private var colorPrimary:FlxColor = FlxColor.fromHSB(0, 0, 0.75, 1);
	private var colorDark:FlxColor = FlxColor.fromHSB(0, 0, 0.5, 1);
	private var colorBackground:FlxColor = FlxColor.fromHSB(0, 0, 0.25, 1);

	public function setSlots(_slots:FlxTypedGroup<Slot>)
	{
		this.slots = _slots;
	}

	public function setPieces(_pieces:FlxTypedGroup<Piece>)
	{
		this.pieces = _pieces;
	}

	public function setColors(_colorLight:FlxColor, _colorPrimary:FlxColor, _colorDark:FlxColor, _colorBackground:FlxColor)
	{
		this.colorLight = _colorLight;
		this.colorPrimary = _colorPrimary;
		this.colorDark = _colorDark;
		this.colorBackground = _colorBackground;
	}

	public function setParent(_parent:Player)
	{
		this.parent = _parent;
	}

	public function getParent():Player
	{
		return this.parent;
	}

	// Constructor
	public function new(_x:Float = 0, _y:Float = 0)
	{
		Log.trace("In Slot X: " + _x + ", Y: " + _y);

		super(_x, _y);
	}

	public function getCenter()
	{
		// Returns the center point of the player
		return new FlxPoint(this.x + Std.int(this.width / 2), this.y + Std.int(this.height / 2));
	}

	public function create(?_slots:FlxTypedGroup<Slot>, ?_pieces:FlxTypedGroup<Piece>)
	{
		// The default dimensions
		var _width = 50;
		var _height = 50;

		// Replace with Board Graphic
		makeGraphic(_width, _height, FlxColor.TRANSPARENT);
	}

	public function getPiecesOnSlot():FlxTypedGroup<Piece>
	{
		var _pieces:FlxTypedGroup<Piece> = new FlxTypedGroup<Piece>(3);

		if (this.pieces != null)
		{
			for (i in 0...this.pieces.length)
			{
				if (this.overlaps(this.pieces.members[i]))
				{
					_pieces.add(this.pieces.members[i]);
				}
			}

			// Log.trace("Slot Piece Length: " + _pieces.length);
		}
		else
		{
			Log.trace("Error: can not Read Slot. Global Pieces Not Defined");
		}

		return _pieces;
	} // End getPiecesOnSlot

	public function readPiecesByRef(_pieces:FlxTypedGroup<Piece>)
	{
		// var _pieces:FlxTypedGroup<Piece> = new FlxTypedGroup<Piece>(3);

		if (this.pieces != null)
		{
			for (i in 0...this.pieces.length)
			{
				if (this.overlaps(this.pieces.members[i]))
				{
					_pieces.add(this.pieces.members[i]);
				}
			}
		}
		else
		{
			Log.trace("Error: can not Read Slot. Global Pieces Not Defined");
		}

		return _pieces;
	} // End getPiecesOnSlo

	public function hasSpace(_size:Int):Bool
	{
		var _space:Bool = true;
		var _foundCount:Int = 0;
		var _onPieces:FlxTypedGroup<Piece> = this.getPiecesOnSlot();

		for (i in 0..._onPieces.length)
		{
			if (_onPieces.members[i].getPiecesSize() == _size)
			{
				_foundCount++;
			}
		}

		if (_foundCount > 1)
		{
			_space = false;
		}
		return _space;
	}

	public function createPieces(_locked:Bool = true):FlxTypedGroup<Piece>
	{
		this.slotPieces = new FlxTypedGroup<Piece>(3);

		this.slotPieces.add(new Piece());
		this.slotPieces.add(new Piece());
		this.slotPieces.add(new Piece());

		this.slotPieces.members[0].setPiecesSize(Piece.SMALL);
		this.slotPieces.members[1].setPiecesSize(Piece.MEDIUM);
		this.slotPieces.members[2].setPiecesSize(Piece.LARGE);

		this.slotPieces.members[0].setPiecesColor(this.colorLight);
		this.slotPieces.members[1].setPiecesColor(this.colorPrimary);
		this.slotPieces.members[2].setPiecesColor(this.colorDark);

		this.slotPieces.members[0].create(_locked);
		this.slotPieces.members[1].create(_locked);
		this.slotPieces.members[2].create(_locked);

		this.slotPieces.members[0].screenCenter();
		this.slotPieces.members[1].screenCenter();
		this.slotPieces.members[2].screenCenter();

		this.slotPieces.members[0].setSlots(this.slots);
		this.slotPieces.members[1].setSlots(this.slots);
		this.slotPieces.members[2].setSlots(this.slots);

		this.slotPieces.members[0].setParent(this);
		this.slotPieces.members[1].setParent(this);
		this.slotPieces.members[2].setParent(this);

		this.pieces.add(this.slotPieces.members[2]);
		this.pieces.add(this.slotPieces.members[1]);
		this.pieces.add(this.slotPieces.members[0]);

		this.slotPieces.members[0].moveTo(this.getCenter());
		this.slotPieces.members[1].moveTo(this.getCenter());
		this.slotPieces.members[2].moveTo(this.getCenter());

		return this.slotPieces;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// Check if slotPieces is defined
		if (this.slotPieces != null)
		{
			if (FlxG.mouse.justPressed)
			{
				for (i in 0...this.slotPieces.length)
				{
					if (FlxG.mouse.overlaps(this.slotPieces.members[i]))
					{
						this.slotPieces.members[i].onClicked();
						break;
					}
				} // End For loop
			} // End if justPressed

			if (FlxG.mouse.justReleased)
			{
				for (j in 0...this.slotPieces.length)
				{
					if ((FlxG.mouse.overlaps(this.slotPieces.members[j])) && this.slotPieces.members[j].isPickedup())
					{
						this.slotPieces.members[j].onDroped();
					}
				} // End For loop
			} // End if justReleased
		} // End if
	} // End Update
}
