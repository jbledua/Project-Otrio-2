import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class GameOverState extends FlxState
{
	private var winner:Int = 0;
	private var color:FlxColor = FlxColor.WHITE;

	override public function new(_winner:Int, _color:FlxColor)
	{
		super();

		this.winner = _winner;
		this.color = _color;
	}

	override public function create():Void
	{
		super.create();

		var text:FlxText = new FlxText(0, FlxG.height / 2 - 50, FlxG.width, "Game Over");
		text.setFormat(null, 64, 0xffffffff, "center");

		FlxTween.color(text, 1, FlxColor.WHITE, FlxColor.RED, {type: FlxTweenType.PINGPONG});

		var winner:FlxText = new FlxText(0, FlxG.height / 2 + 50, FlxG.width, "Player " + this.winner + " wins!");
		winner.setFormat(null, 32, 0xffffffff, "center");

		FlxTween.color(winner, 1, this.color, FlxColor.WHITE, {type: FlxTweenType.PINGPONG});

		add(text);
		add(winner);
	}
}
