package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.ui.FlxSpriteButton;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.util.FlxSignal;
import haxe.Log;

class PlayState extends FlxState
{
	private var board:Board;
	private var players:FlxTypedGroup<Player>;
	private var pieces:FlxTypedGroup<Piece>;
	private var slots:FlxTypedGroup<Slot>;

	private var endTurnSignal:FlxSignal;

	private var turnIndex:Int = 0;
	private var turnText:FlxText;

	override public function create()
	{
		super.create();

		// this.board = new Board();
		this.pieces = new FlxTypedGroup<Piece>(36); // Max of 36 Pieces (12 Per Player in 4v4 - 14 Per Player in 2v2)
		this.slots = new FlxTypedGroup<Slot>(21); // Max of 21 Slots (3 per Player and 9 in the Board)

		// Create Game Board
		this.createBoard();

		// Create Game Players
		this.createPlayers();

		// Create Game Peices
		this.createPeices();

		// Create Turn Text
		this.createTurnText();

		// Create Next Button
		this.createNextButton();

		add(this.board);
		add(this.players);
		add(this.slots);
		add(this.pieces);

		this.players.members[this.turnIndex].startTurn();
	}

	public function createTurnText()
	{
		this.turnText = new FlxText(0, 50, 300, "Player " + Std.string(this.turnIndex + 1) + " Turn");
		this.turnText.screenCenter(FlxAxes.X);
		this.turnText.setFormat(null, 32, FlxColor.WHITE, FlxTextAlign.CENTER);

		this.updateTurnText();

		add(turnText);
	}

	public function updateTurnText()
	{
		// Update Turn Text
		this.turnText.text = "Player " + Std.string(this.turnIndex + 1) + " Turn";

		// Update Turn Text Color
		FlxTween.color(this.turnText, 0.5, FlxColor.WHITE, this.players.members[this.turnIndex].getPrimaryColor());
	}

	public function createNextButton()
	{
		var nextButton:FlxSpriteButton = new FlxSpriteButton(0, 0, null, endTurn);
		nextButton.scale.set(5, 5);

		nextButton.screenCenter();
		nextButton.x += 200 + nextButton.width / 2;
		nextButton.y += 200 + nextButton.height / 2;

		nextButton.loadGraphic('assets/images/green-next.png', true, 16, 16);

		add(nextButton);
	}

	public function createBoard()
	{
		// Instantiate Board Variables
		this.board = new Board();

		// Create Game Board
		this.board.create();
		this.board.screenCenter();

		this.board.setPieces(this.pieces); // To be used for checking overlap
		this.board.setSlots(this.slots); // To be used for checking overlap

		this.board.createSlots();
	}

	public function createPlayers()
	{
		// This function could be impoved using for loops but it works for now

		endTurnSignal = new FlxSignal();
		endTurnSignal.add(onEndTurn);

		// Instantiate Player Variables
		this.players = new FlxTypedGroup<Player>(4); // Max of Players Players

		// Instantiate Player Variables
		this.players.add(new Player());
		this.players.add(new Player());
		this.players.add(new Player());
		this.players.add(new Player());

		// Set Player Orenetation
		this.players.members[0].setType(Player.VERTICAL);
		this.players.members[1].setType(Player.HORIZONTAL);
		this.players.members[2].setType(Player.VERTICAL);
		this.players.members[3].setType(Player.HORIZONTAL);

		// Set Player Colors
		this.players.members[0].setColors(FlxColor.fromHSB(0, 1, 1, 1), FlxColor.fromHSB(0, 1, 0.75, 1), FlxColor.fromHSB(0, 1, 0.5, 1),
			FlxColor.fromHSB(0, 1, 0.25, 1));
		this.players.members[1].setColors(FlxColor.fromHSB(240, 1, 1, 1), FlxColor.fromHSB(240, 1, 0.75, 1), FlxColor.fromHSB(240, 1, 0.5, 1),
			FlxColor.fromHSB(240, 1, 0.25, 1));
		this.players.members[2].setColors(FlxColor.fromHSB(120, 1, 1, 1), FlxColor.fromHSB(120, 1, 0.75, 1), FlxColor.fromHSB(120, 1, 0.5, 1),
			FlxColor.fromHSB(120, 1, 0.25, 1));
		this.players.members[3].setColors(FlxColor.fromHSB(300, 1, 1, 1), FlxColor.fromHSB(300, 1, 0.75, 1), FlxColor.fromHSB(300, 1, 0.5, 1),
			FlxColor.fromHSB(300, 1, 0.25, 1));

		// Set Plater Numbers
		this.players.members[0].setPlayerNumber(0);
		this.players.members[1].setPlayerNumber(1);
		this.players.members[2].setPlayerNumber(2);
		this.players.members[3].setPlayerNumber(3);

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
	}

	public function createPeices()
	{
		// This function could be impoved using for loops but it works for now

		// Add Pieces Group to Players (To be used for checking overlap)
		this.players.members[0].setPieces(this.pieces); // To be used for checking overlap
		this.players.members[1].setPieces(this.pieces); // To be used for checking overlap
		this.players.members[2].setPieces(this.pieces); // To be used for checking overlap
		this.players.members[3].setPieces(this.pieces); // To be used for checking overlap

		this.players.members[0].setSlots(this.slots); // To be used for checking overlap
		this.players.members[1].setSlots(this.slots); // To be used for checking overlap
		this.players.members[2].setSlots(this.slots); // To be used for checking overlap
		this.players.members[3].setSlots(this.slots); // To be used for checking overlap

		this.players.members[0].createSlots();
		this.players.members[1].createSlots();
		this.players.members[2].createSlots();
		this.players.members[3].createSlots();

		this.players.members[0].createPieces(false);
		this.players.members[1].createPieces(true);
		this.players.members[2].createPieces(true);
		this.players.members[3].createPieces(true);
	}

	public function endTurn()
	{
		// End Current turn
		this.players.members[this.turnIndex].endTurn();

		endTurnSignal.dispatch();

		// // Increment turnIndex and loop
		// if (this.turnIndex < this.players.length - 1)
		// 	this.turnIndex++;
		// else
		// 	this.turnIndex = 0;

		// // Start Next turn
		// this.players.members[this.turnIndex].startTurn();
	}

	public function onEndTurn()
	{
		if (this.board.checkWin() != -1)
		{
			Log.trace("Winner: " + this.board.checkWin());
		}
		else
		{
			// Increment turnIndex and loop
			if (this.turnIndex < this.players.length - 1)
				this.turnIndex++;
			else
				this.turnIndex = 0;

			// Start Next turn
			this.players.members[this.turnIndex].startTurn();

			// Update turn text
			this.updateTurnText();
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		var _winner:Int = -1;

		if (FlxG.keys.justPressed.C)
		{
			_winner = this.board.checkWin();

			if (_winner == -1)
				Log.trace("No Winner");
			else
				Log.trace("Winner: " + _winner);
		}

		if (FlxG.keys.justPressed.N)
		{
			this.endTurn();
		}

		if (FlxG.keys.justPressed.ONE)
		{
			Log.trace("Small Pieces");
			// this.logArray2D(this.board.readSmallPieces());

			_winner = this.checkWin(this.board.readSmallPieces());

			if (_winner == -1)
				Log.trace("No Winner");
			else
				Log.trace("Winner: " + _winner);
		}

		if (FlxG.keys.justPressed.TWO)
		{
			Log.trace("Med Pieces");
			// this.logArray2D(this.board.readMedPieces());

			_winner = this.checkWin(this.board.readMedPieces());

			if (_winner == -1)
				Log.trace("No Winner");
			else
				Log.trace("Winner: " + _winner);
		}

		if (FlxG.keys.justPressed.THREE)
		{
			Log.trace("Large Pieces");
			// this.logArray2D(this.board.readLargePieces());

			_winner = this.checkWin(this.board.readLargePieces());

			if (_winner == -1)
				Log.trace("No Winner");
			else
				Log.trace("Winner: " + _winner);
		}

		if (FlxG.keys.justPressed.R)
		{
			this.players.members[this.turnIndex].resetPieces();
		}

		if (FlxG.keys.justPressed.B)
		{
			this.logArray3D(this.board.readBoard());
		}

		if (FlxG.keys.justPressed.NUMPADSEVEN)
			Log.trace("[0][0]:" + this.board.readSlotNMSize(0, 0));

		if (FlxG.keys.justPressed.NUMPADEIGHT)
			Log.trace("[0][1]:" + this.board.readSlotNMSize(0, 1));

		if (FlxG.keys.justPressed.NUMPADNINE)
			Log.trace("[0][2]:" + this.board.readSlotNMSize(0, 2));

		if (FlxG.keys.justPressed.NUMPADFOUR)
			Log.trace("[1][0]:" + this.board.readSlotNMSize(1, 0));

		if (FlxG.keys.justPressed.NUMPADFIVE)
			Log.trace("[1][1]:" + this.board.readSlotNMSize(1, 1));

		if (FlxG.keys.justPressed.NUMPADSIX)
			Log.trace("[1][2]:" + this.board.readSlotNMSize(1, 2));

		if (FlxG.keys.justPressed.NUMPADONE)
			Log.trace("[2][0]:" + this.board.readSlotNMSize(2, 0));

		if (FlxG.keys.justPressed.NUMPADTWO)
			Log.trace("[2][1]:" + this.board.readSlotNMSize(2, 1));

		if (FlxG.keys.justPressed.NUMPADTHREE)
			Log.trace("[2][2]:" + this.board.readSlotNMSize(2, 2));
	}

	public function logArray3D(_array:Array<Array<Array<Int>>>)
	{
		for (i in 0..._array.length)
		{
			Log.trace("Board " + i);
			this.logArray2D(_array[i]);
		}
	}

	public function logArray2D(_array:Array<Array<Int>>)
	{
		for (i in 0..._array.length)
		{
			Log.trace(i + ":" + _array[i]);
		}
	}

	function checkWin(_board)
	{
		// Check rows
		for (i in 0...3)
		{
			if (_board[i][0] == _board[i][1] && _board[i][1] == _board[i][2])
			{
				return _board[i][0];
			}
		}

		// Check columns
		for (i in 0...3)
		{
			if (_board[0][i] == _board[1][i] && _board[1][i] == _board[2][i])
			{
				return _board[0][i];
			}
		}

		// Check diagonals
		if (_board[0][0] == _board[1][1] && _board[1][1] == _board[2][2])
		{
			return _board[0][0];
		}
		if (_board[0][2] == _board[1][1] && _board[1][1] == _board[2][0])
		{
			return _board[0][2];
		}

		return -1;
	}
}
