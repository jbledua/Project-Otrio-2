package;

import flixel.FlxGame;
import flixel.util.FlxColor;
import openfl.display.Sprite;

interface ColorPalette
{
	private var colorLight:FlxColor; // = FlxColor.fromHSB(0, 0, 1, 1);
	private var colorPrimary:FlxColor; // = FlxColor.fromHSB(0, 0, 0.75, 1);
	private var colorDark:FlxColor; // = FlxColor.fromHSB(0, 0, 0.5, 1);
	private var colorBackground:FlxColor; // = FlxColor.fromHSB(0, 0, 0.25, 1);
}

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, PlayState));
	}
}
