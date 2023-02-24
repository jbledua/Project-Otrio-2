import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxSignal;
import haxe.Log;

class Player extends FlxSprite
{
	public static inline var VERTICAL:Int = 0;
	public static inline var HORIZONTAL:Int = 1;

	private var board:Board; // Global Board
	private var pieces:FlxTypedGroup<Piece>; // Global Group of all Pieces
	private var slots:FlxTypedGroup<Slot>; // Global Group of all Slots
	private var players:FlxTypedGroup<Player>; // Global Group of all Players

	private var playerPieces:FlxTypedGroup<Piece>; // Local Group of Pieces that belong to the player
	private var playerSlots:FlxTypedGroup<Slot>; // Local Group of Slots that belong to the player
	private var playerNumber:Int = 0;

	private var type:Int = 1; // Used to tell if player is horizontal or vertical

	private var colorLight:FlxColor = FlxColor.fromHSB(0, 0, 1, 1);
	private var colorPrimary:FlxColor = FlxColor.fromHSB(0, 0, 0.75, 1);
	private var colorDark:FlxColor = FlxColor.fromHSB(0, 0, 0.5, 1);
	private var colorBackground:FlxColor = FlxColor.fromHSB(0, 0, 0.25, 1);

	private var endTurnSignal:FlxSignal;

	// Setters and Getters
	public function setBoard(_board:Board)
	{
		this.board = _board;
	}

	public function getBoard():Board
	{
		return this.board;
	}

	// Player
	public function setPlayer(_players:FlxTypedGroup<Player>)
	{
		this.players = _players;
	}

	public function getPlayer():FlxTypedGroup<Player>
	{
		return this.players;
	}

	// Constructor
	public function new(_x:Float = 0, _y:Float = 0)
	{
		super(_x, _y);
	}

	public function setPieces(_pieces:FlxTypedGroup<Piece>)
	{
		this.pieces = _pieces;
	}

	public function setSlots(_slots:FlxTypedGroup<Slot>)
	{
		this.slots = _slots;
	}

	public function setPlayerNumber(_number:Int)
	{
		this.playerNumber = _number;
	}

	public function getPlayerNumber():Int
	{
		return this.playerNumber;
	}

	public function setType(_type:Int)
	{
		this.type = _type;
	}

	public function getType():Int
	{
		return this.type;
	}

	public function setTurnSignal(signal:FlxSignal)
	{
		this.endTurnSignal = signal;
	}

	public function setColors(_colorLight:FlxColor, _colorPrimary:FlxColor, _colorDark:FlxColor, _colorBackground:FlxColor)
	{
		this.colorLight = _colorLight;
		this.colorPrimary = _colorPrimary;
		this.colorDark = _colorDark;
		this.colorBackground = _colorBackground;
	}

	public function getPrimaryColor():FlxColor
	{
		return this.colorPrimary;
	}

	public function getCenter()
	{
		// Returns the center point of the player
		return new FlxPoint(this.x + Std.int(this.width / 2), this.y + Std.int(this.height / 2));
	}

	// Get Player Pieces
	public function getPlayerPieces():FlxTypedGroup<Piece>
	{
		return this.playerPieces;
	}

	// Get Pieces on Slots
	public function getPiecesOnSlots():FlxTypedGroup<Piece>
	{
		var _pieces:FlxTypedGroup<Piece> = new FlxTypedGroup<Piece>(3);

		// Loop through all the slots
		for (i in 0...this.playerSlots.length)
		{
			var _temp:FlxTypedGroup<Piece> = this.playerSlots.members[i].getPiecesOnSlot();

			Log.trace("Slot " + i + " has " + _temp.length + " pieces");
			// If the slot has a piece
			if (_temp != null)
			{
				// Loop through all the pieces on the slot
				for (j in 0..._temp.length)
				{
					// Add the piece to the group
					_pieces.add(_temp.members[j]);
				}
			}
		}

		return _pieces;
	}

	// Get Pieces on slots are of size n
	public function getPiecesOnSlotsOfSize(n:Int):FlxTypedGroup<Piece>
	{
		var _pieces:FlxTypedGroup<Piece> = new FlxTypedGroup<Piece>(3);
		var _piecesOnSlot:FlxTypedGroup<Piece> = this.getPiecesOnSlots();

		// Log.trace("Plength: " + _piecesOnSlot.length);

		for (i in 0..._piecesOnSlot.length)
		{
			if (_piecesOnSlot.members[i].getPiecesSize() == n)
			{
				_pieces.add(_piecesOnSlot.members[i]);
			}
		}

		return _pieces;
	}

	public function create(?_slots:FlxTypedGroup<Slot>, ?_slots:FlxTypedGroup<Slot>)
	{
		Log.trace("Player " + this.playerNumber + " created");

		switch this.type
		{
			case Player.VERTICAL:
				// Replace with vertical player sprite
				// The vertical dimensions
				var _width = 100;
				var _height = 300;
				makeGraphic(_width, _height, this.colorBackground); // Replace with player sprite
			case Player.HORIZONTAL:
				// Replace with horizontal player sprite
				// The horizontal dimensions
				var _width = 300;
				var _height = 100;
				makeGraphic(_width, _height, this.colorBackground); // Replace with player sprite
			default:
				// Replace with vertical player sprite
				// The vertical dimensions
				var _width = 100;
				var _height = 300;
				makeGraphic(_width, _height, this.colorBackground); // Replace with player sprite
		} // End Switch

		this.playerSlots = new FlxTypedGroup<Slot>(3);
		this.playerPieces = new FlxTypedGroup<Piece>(9);
	} // End create()

	public function createSlots(?_slots:FlxTypedGroup<Slot>)
	{
		// This function could be impoved using for loops but it works for now

		// Instantiate Slots
		this.playerSlots.add(new Slot());
		this.playerSlots.add(new Slot());
		this.playerSlots.add(new Slot());

		// Create Slots
		this.playerSlots.members[0].create();
		this.playerSlots.members[1].create();
		this.playerSlots.members[2].create();

		// Set Parent Slots
		this.playerSlots.members[0].setParent(this);
		this.playerSlots.members[1].setParent(this);
		this.playerSlots.members[2].setParent(this);

		// Move Slots into Place
		// Check if Vertical or Horizontal Player
		switch this.type
		{
			case Player.VERTICAL: // Vertical Player
				// Top Slot
				this.playerSlots.members[0].screenCenter();
				this.playerSlots.members[0].y -= this.height / 3;
				this.playerSlots.members[0].x = this.getCenter().x - this.playerSlots.members[0].width / 2;

				// // Middle Slot
				this.playerSlots.members[1].screenCenter();
				this.playerSlots.members[1].x = this.getCenter().x - this.playerSlots.members[1].width / 2;

				// // Bottom Slot
				this.playerSlots.members[2].screenCenter();
				this.playerSlots.members[2].y += this.height / 3;
				this.playerSlots.members[2].x = this.getCenter().x - this.playerSlots.members[2].width / 2;

			case Player.HORIZONTAL: // Horizontal Player
				// Left Slot
				this.playerSlots.members[0].screenCenter();
				this.playerSlots.members[0].x -= this.width / 3;
				this.playerSlots.members[0].y = this.getCenter().y - this.playerSlots.members[0].height / 2;

				// // Right Slot
				this.playerSlots.members[1].screenCenter();
				this.playerSlots.members[1].y = this.getCenter().y - this.playerSlots.members[1].height / 2;

				// // Right Slot
				this.playerSlots.members[2].screenCenter();
				this.playerSlots.members[2].x += this.width / 3;
				this.playerSlots.members[2].y = this.getCenter().y - this.playerSlots.members[2].height / 2;
		} // End Switch
		this.playerSlots.members[0].setColors(this.colorLight, this.colorPrimary, this.colorDark, this.colorBackground);
		this.playerSlots.members[1].setColors(this.colorLight, this.colorPrimary, this.colorDark, this.colorBackground);
		this.playerSlots.members[2].setColors(this.colorLight, this.colorPrimary, this.colorDark, this.colorBackground);

		this.playerSlots.members[0].setPieces(this.pieces);
		this.playerSlots.members[1].setPieces(this.pieces);
		this.playerSlots.members[2].setPieces(this.pieces);

		this.playerSlots.members[0].setSlots(this.slots);
		this.playerSlots.members[1].setSlots(this.slots);
		this.playerSlots.members[2].setSlots(this.slots);

		// Add Slots to Global list
		this.slots.add(playerSlots.members[0]);
		this.slots.add(playerSlots.members[1]);
		this.slots.add(playerSlots.members[2]);
	} // End createSlots()

	public function createPieces(_locked:Bool = true, ?_slots:FlxTypedGroup<Slot>)
	{
		// This function could be impoved using for loops but it works for now

		for (i in 0...this.playerSlots.length)
		{
			var _tempPiece:FlxTypedGroup<Piece> = this.playerSlots.members[i].createPieces(_locked);

			for (j in 0..._tempPiece.length)
			{
				this.playerPieces.add(_tempPiece.members[j]);
			} // End for j
		} // End for i

		// var _temp1:FlxTypedGroup<Piece> = this.playerSlots.members[0].createPieces(_locked);
		// var _temp2:FlxTypedGroup<Piece> = this.playerSlots.members[1].createPieces(_locked);
		// var _temp3:FlxTypedGroup<Piece> = this.playerSlots.members[2].createPieces(_locked);

		// for (j in 0..._temp1.length)
		// {
		// 	this.playerPieces.add(_temp1.members[j]);
		// }

		// for (j in 0..._temp2.length)
		// {
		// 	this.playerPieces.add(_temp2.members[j]);
		// }

		// for (j in 0..._temp3.length)
		// {
		// 	this.playerPieces.add(_temp3.members[j]);
		// }
		/*
			// Instantiate pieces
			this.playerPieces.add(new Piece());
			this.playerPieces.add(new Piece());
			this.playerPieces.add(new Piece());

			this.playerPieces.add(new Piece());
			this.playerPieces.add(new Piece());
			this.playerPieces.add(new Piece());

			this.playerPieces.add(new Piece());
			this.playerPieces.add(new Piece());
			this.playerPieces.add(new Piece());

			// Set Pieces Sizes
			this.playerPieces.members[0].setPiecesSize(Piece.LARGE);
			this.playerPieces.members[3].setPiecesSize(Piece.MEDIUM);
			this.playerPieces.members[6].setPiecesSize(Piece.SMALL);

			this.playerPieces.members[1].setPiecesSize(Piece.LARGE);
			this.playerPieces.members[4].setPiecesSize(Piece.MEDIUM);
			this.playerPieces.members[7].setPiecesSize(Piece.SMALL);

			this.playerPieces.members[2].setPiecesSize(Piece.LARGE);
			this.playerPieces.members[5].setPiecesSize(Piece.MEDIUM);
			this.playerPieces.members[8].setPiecesSize(Piece.SMALL);

			// Set Pieces Sizes
			this.playerPieces.members[0].setPiecesColor(this.colorDark);
			this.playerPieces.members[1].setPiecesColor(this.colorDark);
			this.playerPieces.members[2].setPiecesColor(this.colorDark);

			this.playerPieces.members[3].setPiecesColor(this.colorPrimary);
			this.playerPieces.members[4].setPiecesColor(this.colorPrimary);
			this.playerPieces.members[5].setPiecesColor(this.colorPrimary);

			this.playerPieces.members[6].setPiecesColor(this.colorLight);
			this.playerPieces.members[7].setPiecesColor(this.colorLight);
			this.playerPieces.members[8].setPiecesColor(this.colorLight);

			// Create Pieces
			this.playerPieces.members[0].create();
			this.playerPieces.members[1].create();
			this.playerPieces.members[2].create();

			this.playerPieces.members[3].create();
			this.playerPieces.members[4].create();
			this.playerPieces.members[5].create();

			this.playerPieces.members[6].create();
			this.playerPieces.members[7].create();
			this.playerPieces.members[8].create();

			// Start Pieces in the Center
			this.playerPieces.members[0].screenCenter();
			this.playerPieces.members[1].screenCenter();
			this.playerPieces.members[2].screenCenter();

			this.playerPieces.members[3].screenCenter();
			this.playerPieces.members[4].screenCenter();
			this.playerPieces.members[5].screenCenter();

			this.playerPieces.members[6].screenCenter();
			this.playerPieces.members[7].screenCenter();
			this.playerPieces.members[8].screenCenter();

			// Set slots
			this.playerPieces.members[0].setSlots(this.slots);
			this.playerPieces.members[1].setSlots(this.slots);
			this.playerPieces.members[2].setSlots(this.slots);
			this.playerPieces.members[3].setSlots(this.slots);
			this.playerPieces.members[4].setSlots(this.slots);
			this.playerPieces.members[5].setSlots(this.slots);
			this.playerPieces.members[6].setSlots(this.slots);
			this.playerPieces.members[7].setSlots(this.slots);
			this.playerPieces.members[8].setSlots(this.slots);

			// Set Parent
			// this.playerPieces.members[0].setParent(this);
			// this.playerPieces.members[1].setParent(this);
			// this.playerPieces.members[2].setParent(this);
			// this.playerPieces.members[3].setParent(this);
			// this.playerPieces.members[4].setParent(this);
			// this.playerPieces.members[5].setParent(this);
			// this.playerPieces.members[6].setParent(this);
			// this.playerPieces.members[7].setParent(this);
			// this.playerPieces.members[8].setParent(this);

			// Add Piece to globle list
			this.pieces.add(this.playerPieces.members[0]);
			this.pieces.add(this.playerPieces.members[1]);
			this.pieces.add(this.playerPieces.members[2]);
			this.pieces.add(this.playerPieces.members[3]);
			this.pieces.add(this.playerPieces.members[4]);
			this.pieces.add(this.playerPieces.members[5]);
			this.pieces.add(this.playerPieces.members[6]);
			this.pieces.add(this.playerPieces.members[7]);
			this.pieces.add(this.playerPieces.members[8]);

			// Move Piece to Location
			this.playerPieces.members[0].moveTo(this.playerSlots.members[0].getCenter());
			this.playerPieces.members[3].moveTo(this.playerSlots.members[0].getCenter());
			this.playerPieces.members[6].moveTo(this.playerSlots.members[0].getCenter());

			this.playerPieces.members[1].moveTo(this.playerSlots.members[1].getCenter());
			this.playerPieces.members[4].moveTo(this.playerSlots.members[1].getCenter());
			this.playerPieces.members[7].moveTo(this.playerSlots.members[1].getCenter());

			this.playerPieces.members[2].moveTo(this.playerSlots.members[2].getCenter());
			this.playerPieces.members[5].moveTo(this.playerSlots.members[2].getCenter());
			this.playerPieces.members[8].moveTo(this.playerSlots.members[2].getCenter());

			// */
	} // End createPieces

	public function startTurn()
	{
		Log.trace("Player " + this.playerNumber + " - Start Turn");

		for (i in 0...this.playerPieces.length)
		{
			this.playerPieces.members[i].unlock();
		} // End for i

		// Log.trace("Pieces on slot 0 " + this.playerSlots.members[0].readPieces().length);
		// Log.trace("Pieces on slot 1 " + this.playerSlots.members[1].readPieces().length);
		// Log.trace("Pieces on slot 2 " + this.playerSlots.members[2].readPieces().length);

		// for (i in 0...this.playerSlots.length)
		// {
		// 	this.playerPieces.members[i].unlock();
		// }

		// _pieces:FlxTypedGroup<Piece>= new FlxTypedGroup<Piece>(3);

		// var _tempPieces:FlxTypedGroup<Piece> = new FlxTypedGroup<Piece>(6);

		// for (i in 0...this.playerSlots.length)
		// {
		// 	// var _tempPieces1:FlxTypedGroup<Piece> = this.playerSlots.members[i].readPieces();

		// 	var _pieces:FlxTypedGroup<Piece> = new FlxTypedGroup<Piece>(3);

		// 	this.playerSlots.members[i].readPiecesByRef(_pieces);

		// 	Log.trace("Pieces on slot " + i + " " + _pieces.length);

		// 	// for (j in 0..._pieces.length)
		// 	// {
		// 	// 	_pieces.members[j].unlock();
		// 	// }
		// }

		// var _pieces1:FlxTypedGroup<Piece> = new FlxTypedGroup<Piece>(3);
		// var _pieces2:FlxTypedGroup<Piece> = new FlxTypedGroup<Piece>(3);
		// var _pieces3:FlxTypedGroup<Piece> = new FlxTypedGroup<Piece>(3);

		// this.playerSlots.members[0].readPiecesByRef(_pieces1);
		// this.playerSlots.members[1].readPiecesByRef(_pieces2);
		// this.playerSlots.members[2].readPiecesByRef(_pieces3);

		// Log.trace("Pieces on slot " + 0 + " " + _pieces1.length);
		// Log.trace("Pieces on slot " + 1 + " " + _pieces2.length);
		// Log.trace("Pieces on slot " + 2 + " " + _pieces3.length);
	}

	public function endTurn()
	{
		Log.trace("Player " + this.playerNumber + " - End Turn");

		for (i in 0...this.playerPieces.length)
		{
			this.playerPieces.members[i].lock();
		} // End for i

		this.endTurnSignal.dispatch();
	}

	public function resetPieces()
	{
		Log.trace("Player " + this.playerNumber + " - Reset Pieces");

		for (i in 0...this.playerPieces.length)
		{
			this.playerPieces.members[i].resetLocation();
		} // End for i
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		/*
			if (FlxG.mouse.justPressed)
			{
				var i = this.playerPieces.length - 1;
				while (i >= 0)
				{
					if (FlxG.mouse.overlaps(this.playerPieces.members[i]))
					{
						this.playerPieces.members[i].onClicked();
						break;
					}
					i--;
				} // End For loop
			}

			if (FlxG.mouse.justReleased)
			{
				for (j in 0...this.playerPieces.length)
				{
					if (FlxG.mouse.overlaps(this.playerPieces.members[j]))
					{
						this.playerPieces.members[j].onDroped();
					}
				} // End For loop
			}
			// */
	} // End update
} // End Player
