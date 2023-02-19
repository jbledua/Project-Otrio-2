import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import haxe.Log;

class Board extends FlxSprite
{
	private var pieces:FlxTypedGroup<Piece>;
	private var slots:FlxTypedGroup<Slot>;

	private var boardSlots:FlxTypedGroup<Slot>;

	// Constructor
	public function new(_x:Float = 0, _y:Float = 0)
	{
		super(x, y);
	}

	public function setPieces(_pieces:FlxTypedGroup<Piece>)
	{
		this.pieces = _pieces;
	}

	public function setSlots(_slots:FlxTypedGroup<Slot>)
	{
		this.slots = _slots;
	}

	public function create()
	{
		// The default dimensions
		var _width = 300;
		var _height = 300;

		// Replace with Board Graphic
		makeGraphic(_width, _height, FlxColor.WHITE);
	}

	public function createSlots()
	{
		// This function could be impoved using for loops but it works for now

		this.boardSlots = new FlxTypedGroup<Slot>(9); // Instantiate Slots

		this.boardSlots.add(new Slot());
		this.boardSlots.add(new Slot());
		this.boardSlots.add(new Slot());
		this.boardSlots.add(new Slot());
		this.boardSlots.add(new Slot());
		this.boardSlots.add(new Slot());
		this.boardSlots.add(new Slot());
		this.boardSlots.add(new Slot());
		this.boardSlots.add(new Slot());

		// Create Slots
		// Top Row
		this.boardSlots.members[0].create();
		this.boardSlots.members[1].create();
		this.boardSlots.members[2].create();

		// Middle Row
		this.boardSlots.members[3].create();
		this.boardSlots.members[4].create();
		this.boardSlots.members[5].create();

		// Bottom Row
		this.boardSlots.members[6].create();
		this.boardSlots.members[7].create();
		this.boardSlots.members[8].create();

		// Move Slots into Place
		// Top Row
		this.boardSlots.members[0].screenCenter();
		this.boardSlots.members[0].x -= this.width / 3;
		this.boardSlots.members[0].y -= this.height / 3;
		this.boardSlots.members[1].screenCenter();
		this.boardSlots.members[1].y -= this.height / 3;
		this.boardSlots.members[2].screenCenter();
		this.boardSlots.members[2].x += this.width / 3;
		this.boardSlots.members[2].y -= this.height / 3;

		// Middle Row
		this.boardSlots.members[3].screenCenter();
		this.boardSlots.members[3].x -= this.width / 3;
		this.boardSlots.members[4].screenCenter();
		this.boardSlots.members[5].screenCenter();
		this.boardSlots.members[5].x += this.width / 3;

		// Bottom Row
		this.boardSlots.members[6].screenCenter();
		this.boardSlots.members[6].x -= this.width / 3;
		this.boardSlots.members[6].y += this.height / 3;
		this.boardSlots.members[7].screenCenter();
		this.boardSlots.members[7].y += this.height / 3;
		this.boardSlots.members[8].screenCenter();
		this.boardSlots.members[8].x += this.width / 3;
		this.boardSlots.members[8].y += this.height / 3;

		// Instantiate Slots
		this.slots.add(this.boardSlots.members[0]);
		this.slots.add(this.boardSlots.members[1]);
		this.slots.add(this.boardSlots.members[2]);
		this.slots.add(this.boardSlots.members[3]);
		this.slots.add(this.boardSlots.members[4]);
		this.slots.add(this.boardSlots.members[5]);
		this.slots.add(this.boardSlots.members[6]);
		this.slots.add(this.boardSlots.members[7]);
		this.slots.add(this.boardSlots.members[8]);
	} // End createSlots

	public function readSmallPieces():Array<Array<Int>>
	{
		var _array:Array<Array<Int>> = [[-1, -1, -1], [-1, -1, -1], [-1, -1, -1]];

		var _array2:Array<Int> = [0, 1, 2, 3, 4, 5, 6, 7, 8];

		for (i in 0...3)
		{
			for (j in 0...3)
			{
				// _array[i][j] = _array2[i * 3 + j];

				var _tempPieces:FlxTypedGroup<Piece> = boardSlots.members[i * 3 + j].readPieces();

				if (_tempPieces.length != null)
				{
					for (k in 0..._tempPieces.length)
					{
						if (_tempPieces.members[k].getPiecesSize() == Piece.SMALL)
						{
							_array[i][j] = 2;
						}
					} // End For k
				} // End if
			} // End For j
		} // End For i

		// for (i in 0...boardSlots.length)
		// {
		// 	var _tempPieces:FlxTypedGroup<Piece> = boardSlots.members[i].readPieces();

		// 	for (j in 0..._tempPieces.length)
		// 	{
		// 		if (_tempPieces.members)
		// 	}
		// }

		return _array;
	}

	public function readMedPieces():Array<Array<Int>>
	{
		var _array:Array<Array<Int>> = [[-1, -1, -1], [-1, -1, -1], [-1, -1, -1]];

		// Log.trace("|-1,-1,-1|");
		// Log.trace("|-1,-1,-1|");
		// Log.trace("|-1,-1,-1|");

		return _array;
	}

	public function readLargePieces():Array<Array<Int>>
	{
		var _array:Array<Array<Int>> = [[-1, -1, -1], [-1, -1, -1], [-1, -1, -1]];

		// Log.trace("|-1,-1,-1|");
		// Log.trace("|-1,-1,-1|");
		// Log.trace("|-1,-1,-1|");

		return _array;
	}

	public function readBoard():Array<Array<Array<Int>>>
	{
		var _array:Array<Array<Array<Int>>> = [
			[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1]],
			[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1]],
			[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1]]
		];

		// Log.trace("|-1,-1,-1|");
		// Log.trace("|-1,-1,-1|");
		// Log.trace("|-1,-1,-1|");

		return _array;
	}
}
