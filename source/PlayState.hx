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
	var player:Player;

	override public function create():Void
	{
		super.create();
		FlxG.mouse.visible = false;
		level = new Level("test");
		add(level);

		player = new Player();
		player.x = level.start.x;
		player.y = level.start.y;
		add(player);
	}

	override public function destroy():Void
	{
		super.destroy();
		level = null;
		player = null;
		FlxG.mouse.visible = true;
	}

	override public function update():Void
	{
		var dX = 0;
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.A) { --dX; }
		if (FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.D) { ++dX; }
		player.setDirectionX(dX);
		player.setJump(FlxG.keys.pressed.SPACE || FlxG.keys.pressed.UP || FlxG.keys.pressed.W);

		super.update();
		FlxG.collide(player, level);
	}
}
