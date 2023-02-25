import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class GameOverState extends FlxSubState
{
	private var winner:Int = 0;
	private var color:FlxColor = FlxColor.WHITE;

	override public function new(_winner:Int, _color:FlxColor)
	{
		super(0x33000000);

		this.winner = _winner;
		this.color = _color;
	}

	override public function create():Void
	{
		// super.create();

		var text:FlxText = new FlxText(0, FlxG.height / 2 - 50, FlxG.width, "Game Over");
		text.setFormat(null, 64, 0xffffffff, "center");
		text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.RED, 4);

		FlxTween.color(text, 1, FlxColor.WHITE, FlxColor.RED, {type: FlxTweenType.PINGPONG});

		var winner:FlxText = new FlxText(0, FlxG.height / 2 + 50, FlxG.width, "Player " + this.winner + " wins!");
		winner.setFormat(null, 32, 0xffffffff, "center");
		winner.setBorderStyle(FlxTextBorderStyle.SHADOW, this.color, 4);

		FlxTween.color(winner, 1, this.color, FlxColor.WHITE, {type: FlxTweenType.PINGPONG});

		add(text);
		add(winner);

		bgColor = 0;
	}
}
