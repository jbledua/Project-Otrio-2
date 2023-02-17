import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import haxe.Log;

class Player extends FlxSprite
{
	private var pieces:FlxTypedGroup<Piece>;
	private var piecesStartIndex:Int = 0; //

	private var slots:FlxTypedGroup<Slot>;
	private var slotStartIndex:Int = 0; //

	private var playerPieces:FlxTypedGroup<Piece>;
	private var playerSlots:FlxTypedGroup<Slot>;

	private var type:Int = 1; // Used to tell if player is horizontal or vertical

	private var colorLight:FlxColor = FlxColor.fromHSB(0, 0, 1, 1);
	private var colorPrimary:FlxColor = FlxColor.fromHSB(0, 0, 0.75, 1);
	private var colorDark:FlxColor = FlxColor.fromHSB(0, 0, 0.5, 1);
	private var colorBackground:FlxColor = FlxColor.fromHSB(0, 0, 0.25, 1);

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

	public function setType(_type:Int)
	{
		this.type = _type;
	}

	public function getType():Int
	{
		return this.type;
	}

	public function setColors(_colorLight:FlxColor, _colorPrimary:FlxColor, _colorDark:FlxColor, _colorBackground:FlxColor)
	{
		this.colorLight = _colorLight;
		this.colorPrimary = _colorPrimary;
		this.colorDark = _colorDark;
		this.colorBackground = _colorBackground;
	}

	public function getCenter()
	{
		// Returns the center point of the player
		return new FlxPoint(this.x + Std.int(this.width / 2), this.y + Std.int(this.height / 2));
	}

	public function create()
	{
		switch this.type
		{
			case 0:
				// Replace with horizontal player sprite
				// The horizontal dimensions
				var _width = 100;
				var _height = 300;
				makeGraphic(_width, _height, this.colorBackground);
			// makeGraphic(_width, _height, FlxColor.RED);
			case 1:
				// Replace with vertical player sprite
				// The vertical dimensions
				var _width = 300;
				var _height = 100;
				makeGraphic(_width, _height, this.colorBackground);
			default:
				// Replace with vertical player sprite
				// The default dimensions
				var _width = 300;
				var _height = 100;
				makeGraphic(_width, _height, this.colorBackground);
		} // End Switch

		this.playerSlots = new FlxTypedGroup<Slot>(3);
		this.playerPieces = new FlxTypedGroup<Piece>(9);
	} // End create()

	public function createSlots()
	{
		// This function could be impoved using for loops but it works for now

		// Set where to start adding slots
		this.slotStartIndex = this.slots.length;

		// Instantiate Slots
		this.playerSlots.add(new Slot());
		this.playerSlots.add(new Slot());
		this.playerSlots.add(new Slot());

		// Create Slots
		this.playerSlots.members[0].create();
		this.playerSlots.members[1].create();
		this.playerSlots.members[2].create();

		// Move Slots into Place
		// Check if Vertical or Horizontal Player
		switch this.type
		{
			case 0: // Vertical Player
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

			case 1: // Horizontal Player
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

		// Add Slots to Global list
		this.slots.add(playerSlots.members[0]);
		this.slots.add(playerSlots.members[1]);
		this.slots.add(playerSlots.members[2]);
	} // End createSlots()

	public function createPieces()
	{
		// Set where to start adding pieases
		this.piecesStartIndex = this.pieces.length;

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
		this.playerPieces.members[0].setPiecesSize(2);
		this.playerPieces.members[3].setPiecesSize(1);
		this.playerPieces.members[6].setPiecesSize(0);

		this.playerPieces.members[1].setPiecesSize(2);
		this.playerPieces.members[4].setPiecesSize(1);
		this.playerPieces.members[7].setPiecesSize(0);

		this.playerPieces.members[2].setPiecesSize(2);
		this.playerPieces.members[5].setPiecesSize(1);
		this.playerPieces.members[8].setPiecesSize(0);

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
	} // createPieces
}
