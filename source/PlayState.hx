package;

import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var board:Board;
	private var players:FlxTypedGroup<Player>;
	private var pieces:FlxTypedGroup<Piece>;
	private var slots:FlxTypedGroup<Slot>;

	override public function create()
	{
		super.create();

		// Instantiate Main Variables
		this.board = new Board();
		this.players = new FlxTypedGroup<Player>(4); // Max of Players Players
		this.pieces = new FlxTypedGroup<Piece>(36); // Max of 36 Pieces (12 Per Player in 4v4 - 14 Per Player in 2v2)
		this.slots = new FlxTypedGroup<Slot>(21); // Max of 21 Slots (3 per Player and 9 in the Board)

		// Create Game Board
		this.board.create();
		this.board.screenCenter();
		this.board.setPieces(this.pieces); // To be used for checking overlap
		this.board.setSlots(this.slots); // To be used for checking overlap

		this.board.createSlots();

		this.createPlayers();

		add(this.board);
		add(this.players);
		add(this.slots);
		add(this.pieces);
	}

	public function createPlayers()
	{
		// This function could be impoved using for loops but it works for now

		// Instantiate Player Variables
		this.players.add(new Player());
		this.players.add(new Player());
		this.players.add(new Player());
		this.players.add(new Player());

		// Set Player Orenetation
		this.players.members[0].setType(0);
		this.players.members[1].setType(1);
		this.players.members[2].setType(0);
		this.players.members[3].setType(1);

		// Set Player Colors
		this.players.members[0].setColors(FlxColor.fromHSB(0, 1, 1, 1), FlxColor.fromHSB(0, 1, 0.75, 1), FlxColor.fromHSB(0, 1, 0.5, 1),
			FlxColor.fromHSB(0, 1, 0.25, 1));
		this.players.members[1].setColors(FlxColor.fromHSB(240, 1, 1, 1), FlxColor.fromHSB(240, 1, 0.75, 1), FlxColor.fromHSB(240, 1, 0.5, 1),
			FlxColor.fromHSB(240, 1, 0.25, 1));
		this.players.members[2].setColors(FlxColor.fromHSB(120, 1, 1, 1), FlxColor.fromHSB(120, 1, 0.75, 1), FlxColor.fromHSB(120, 1, 0.5, 1),
			FlxColor.fromHSB(120, 1, 0.25, 1));
		this.players.members[3].setColors(FlxColor.fromHSB(300, 1, 1, 1), FlxColor.fromHSB(300, 1, 0.75, 1), FlxColor.fromHSB(300, 1, 0.5, 1),
			FlxColor.fromHSB(300, 1, 0.25, 1));

		// Create Player
		this.players.members[0].create();
		this.players.members[1].create();
		this.players.members[2].create();
		this.players.members[3].create();

		// Move Players to Proper Places
		this.players.members[0].screenCenter();
		this.players.members[0].x -= this.board.width / 2 + this.players.members[0].width / 2;
		this.players.members[1].screenCenter();
		this.players.members[1].y -= this.board.height / 2 + this.players.members[1].height / 2;
		this.players.members[2].screenCenter();
		this.players.members[2].x += this.board.width / 2 + this.players.members[2].width / 2;
		this.players.members[3].screenCenter();
		this.players.members[3].y += this.board.height / 2 + this.players.members[3].height / 2;

		// Add Pieces Group to Players (To be used for checking overlap)
		this.players.members[0].setPieces(this.pieces);
		this.players.members[1].setPieces(this.pieces);
		this.players.members[2].setPieces(this.pieces);
		this.players.members[3].setPieces(this.pieces);

		this.players.members[0].setSlots(this.slots); // To be used for checking overlap
		this.players.members[1].setSlots(this.slots); // To be used for checking overlap
		this.players.members[2].setSlots(this.slots); // To be used for checking overlap
		this.players.members[3].setSlots(this.slots); // To be used for checking overlap

		this.players.members[0].createSlots();
		this.players.members[1].createSlots();
		this.players.members[2].createSlots();
		this.players.members[3].createSlots();

		this.players.members[0].createPieces();
		this.players.members[1].createPieces();
		this.players.members[2].createPieces();
		this.players.members[3].createPieces();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
