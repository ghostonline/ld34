package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

class MenuState extends FlxState
{
	var title:FlxText;
	var start:FlxButton;

	override public function create():Void
	{
		super.create();
		start = new FlxButton();
		start.onUp.callback = startGame;
		start.text = "Start";
		start.x = (FlxG.width - start.width) / 2;
		start.y = FlxG.height - 20 - start.height;
		add(start);

		title = new FlxText(0, 20, FlxG.width, "Pot Lug", 32);
		title.alignment = "center";
		add(title);
	}

	function startGame()
	{
		FlxG.switchState(new PlayState());
	}

	override public function destroy():Void
	{
		super.destroy();
		start = null;
		title = null;
	}
}
