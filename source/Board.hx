import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;

class Board extends FlxSprite
{
	private var pieces:FlxTypedGroup<Piece>;
	private var slots:FlxTypedGroup<Slot>;

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

		// Instantiate Slots
		this.slots.add(new Slot());
		this.slots.add(new Slot());
		this.slots.add(new Slot());
		this.slots.add(new Slot());
		this.slots.add(new Slot());
		this.slots.add(new Slot());
		this.slots.add(new Slot());
		this.slots.add(new Slot());
		this.slots.add(new Slot());

		// Create Slots
		// Top Row
		this.slots.members[0].create();
		this.slots.members[1].create();
		this.slots.members[2].create();

		// Middle Row
		this.slots.members[3].create();
		this.slots.members[4].create();
		this.slots.members[5].create();

		// Bottom Row
		this.slots.members[6].create();
		this.slots.members[7].create();
		this.slots.members[8].create();

		// Move Slots into Place
		// Top Row
		this.slots.members[0].screenCenter();
		this.slots.members[0].x -= this.width / 3;
		this.slots.members[0].y -= this.height / 3;
		this.slots.members[1].screenCenter();
		this.slots.members[1].y -= this.height / 3;
		this.slots.members[2].screenCenter();
		this.slots.members[2].x += this.width / 3;
		this.slots.members[2].y -= this.height / 3;

		// Middle Row
		this.slots.members[3].screenCenter();
		this.slots.members[3].x -= this.width / 3;
		this.slots.members[4].screenCenter();
		this.slots.members[5].screenCenter();
		this.slots.members[5].x += this.width / 3;

		// Bottom Row
		this.slots.members[6].screenCenter();
		this.slots.members[6].x -= this.width / 3;
		this.slots.members[6].y += this.height / 3;
		this.slots.members[7].screenCenter();
		this.slots.members[7].y += this.height / 3;
		this.slots.members[8].screenCenter();
		this.slots.members[8].x += this.width / 3;
		this.slots.members[8].y += this.height / 3;
	} // End createSlots
}
