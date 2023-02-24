import flixel.group.FlxGroup;
import haxe.Log;

class PlayerAI extends Player
{
	override public function startTurn()
	{
		Log.trace("Player " + this.playerNumber + " - Start Turn");

		Log.trace("Best move: " + this.bestMove());
		// Log.trace("Best move: " + this.bestMove2d(this.board.readLargePieces()));

		for (i in 0...this.playerPieces.length)
		{
			this.playerPieces.members[i].unlock();
		} // End for i
	}

	override public function endTurn()
	{
		Log.trace("Player " + this.playerNumber + " - End Turn");

		if (this.bestMove() != [-1, -1, -1])
		{
			this.movePiece(this.bestMove()[0], this.bestMove()[1], this.bestMove()[2]);
		}
		else
		{
			Log.trace("No move found");
		}

		for (i in 0...this.playerPieces.length)
		{
			this.playerPieces.members[i].lock();
		} // End for i

		this.endTurnSignal.dispatch();
	}

	public function bestMove():Array<Int>
	{
		// Initialize the arrays
		var _move:Array<Int> = [-1, -1, -1];
		var _array:Array<Int> = [-1, -1];

		_array = this.bestMove2d(this.board.readRightColumns());

		if (_array[0] != -1)
		{
			Log.trace("Right column: " + _array);
			return [_array[0], _array[1], 2];
		}

		_array = this.bestMove2d(this.board.readMidColumns());

		if (_array[0] != -1)
			return [_array[0], _array[1], 1];

		_array = this.bestMove2d(this.board.readLeftColumns());

		if (_array[0] != -1)
			return [_array[0], _array[1], 0];

		// _array = this.bestMove2d(this.board.readBottomRows());

		// If no move was found, pick random -1
		if (_array[0] == -1)
		{
			Log.trace("No move found. Picking randomly");
			for (i in 0...3)
			{
				for (j in 0...3)
				{
					for (k in 0...3)
					{
						if (this.board.readBoard()[i][j][k] == -1)
						{
							return [i, j, k];
						}
					}
				}
			}
		}

		return [-1, -1, -1];
	}

	//*
	public function bestMove2d(_board:Array<Array<Int>>):Array<Int>
	{
		// Check for the winning move
		for (i in 0...3)
		{
			for (j in 0...3)
			{
				if (_board[i][j] == -1)
				{
					_board[i][j] = this.playerNumber;
					if (this.board.checkWin2d(_board) == this.playerNumber)
					{
						return [i, j];
					}
					_board[i][j] = -1;
				}
			}
		}

		// Check for the blocking move

		for (k in 0...this.players.length)
		{
			for (i in 0...3)
			{
				for (j in 0...3)
				{
					if (_board[i][j] == -1)
					{
						_board[i][j] = this.players.members[k].getPlayerNumber();
						if (this.board.checkWin2d(_board) == this.players.members[k].getPlayerNumber())
						{
							return [i, j];
						}
						_board[i][j] = -1;
					}
				}
			}
		}

		// Play the best move
		for (i in 0...3)
		{
			for (j in 0...3)
			{
				if (_board[i][j] == -1)
				{
					return [i, j];
				}
			}
		}

		return [-1, -1];
	} // End function bestMove2d

	// */
	// Move the piece to the board at the given position
	public function movePiece(_size:Int, _y:Int, _z:Int)
	{
		var _pieces:FlxTypedGroup<Piece> = this.getPiecesOnSlotsOfSize(_size);

		if ((this.board.getSlotNM(_y, _z) != null) && _pieces.members[0] != null)
			_pieces.members[0].moveTo(this.board.getSlotNM(_y, _z).getCenter());
		else
		{
			if (_pieces.members[0] == null)
			{
				Log.trace("Error: Piece [0] is null");
				Log.trace("Pieces Length: " + _pieces.length);
			}
			else
				Log.trace("Error: Slot [" + _y + "," + _z + "] is null ");
		}

		// this.board.getSlotNM(_y, _z)
	}
}
