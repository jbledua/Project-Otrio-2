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

	public function create(?_slots:FlxTypedGroup<Slot>, ?_pieces:FlxTypedGroup<Piece>)
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

		// Set Pieces
		// Top Row
		this.boardSlots.members[0].setPieces(this.pieces);
		this.boardSlots.members[1].setPieces(this.pieces);
		this.boardSlots.members[2].setPieces(this.pieces);

		// Middle Row
		this.boardSlots.members[3].setPieces(this.pieces);
		this.boardSlots.members[4].setPieces(this.pieces);
		this.boardSlots.members[5].setPieces(this.pieces);

		// Bottom Row
		this.boardSlots.members[6].setPieces(this.pieces);
		this.boardSlots.members[7].setPieces(this.pieces);
		this.boardSlots.members[8].setPieces(this.pieces);

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

	public function readSlotNSize(_n:Int):Array<Int>
	{
		var _pieceSize:Array<Int> = [];

		if (this.boardSlots != null)
		{
			if (_n < this.slots.length)
			{
				var _tempPieces:FlxTypedGroup<Piece> = this.slots.members[_n].readPieces();

				for (i in 0..._tempPieces.length)
					_pieceSize.push(_tempPieces.members[i].getPiecesSize());
			}
		}

		return _pieceSize;
	}

	public function readPiecesOfNSize(_size:Int):Array<Array<Int>>
	{
		var _array:Array<Array<Int>> = [[-1, -1, -1], [-1, -1, -1], [-1, -1, -1]];

		for (i in 0..._array.length)
		{
			for (j in 0..._array[i].length)
			{
				var _tempPieces:FlxTypedGroup<Piece> = boardSlots.members[i * _array.length + j].readPieces();
				var _playerIndex:Int = -1;

				for (k in 0..._tempPieces.length)
				{
					if (_tempPieces.members[k].getPiecesSize() == _size)
					{
						_playerIndex = _tempPieces.members[k].getParent().getParent().getPlayerNumber();
						break;
					}
				}

				_array[i][j] = _playerIndex;
			}
		}

		return _array;
	} // End readPiecesOfNSize

	//--------------------------------------------------------------------------------------------------------
	//               Small
	// | [0][0][0] [0][0][1] [0][0][2] |
	// | [0][1][0] [0][1][1] [0][1][2] |
	// | [0][2][0] [0][2][1] [0][2][2] |
	//--------------------------------------------------------------------------------------------------------

	public function readSmallPieces():Array<Array<Int>>
	{
		return readPiecesOfNSize(Piece.SMALL);
	}

	//--------------------------------------------------------------------------------------------------------
	//              Medium
	// | [1][0][0] [1][0][1] [1][0][2] |
	// | [1][1][0] [1][1][1] [1][1][2] |
	// | [1][2][0] [1][2][1] [1][2][2] |
	//--------------------------------------------------------------------------------------------------------

	public function readMedPieces():Array<Array<Int>>
	{
		return readPiecesOfNSize(Piece.MEDIUM);
	}

	//--------------------------------------------------------------------------------------------------------
	//               Large
	// | [2][0][0] [2][0][1] [2][0][2] |
	// | [2][1][0] [2][1][1] [2][1][2] |
	// | [2][2][0] [2][2][1] [2][2][2] |
	//--------------------------------------------------------------------------------------------------------

	public function readLargePieces():Array<Array<Int>>
	{
		return readPiecesOfNSize(Piece.LARGE);
	}

	//--------------------------------------------------------------------------------------------------------
	//               Small                               Med                               Large
	// | [0][0][0] [0][0][1] [0][0][2] |  | [1][0][0] [1][0][1] [1][0][2] |  | [2][0][0] [2][0][1] [2][0][2] |
	// | [0][1][0] [0][1][2] [0][1][2] |  | [1][1][0] [1][1][1] [1][1][2] |  | [2][1][0] [2][1][1] [2][1][2] |
	// | [0][2][0] [0][2][1] [0][2][2] |  | [1][2][0] [1][2][1] [1][2][2] |  | [2][2][0] [2][2][1] [2][2][2] |
	//--------------------------------------------------------------------------------------------------------

	public function readBoard():Array<Array<Array<Int>>>
	{
		var _array:Array<Array<Array<Int>>> = [];

		_array.push(readSmallPieces());
		_array.push(readMedPieces());
		_array.push(readLargePieces());

		return _array;
	}
}
