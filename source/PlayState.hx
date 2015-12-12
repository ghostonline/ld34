package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

class PlayState extends FlxState
{
	var level:Level;

	override public function create():Void
	{
		super.create();
		level = new Level("test");
		add(level);
	}

	override public function destroy():Void
	{
		super.destroy();
		level = null;
	}

	override public function update():Void
	{
		super.update();
	}
}
