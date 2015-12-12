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
	var pot:Pot;
	var light:Light;

	override public function create():Void
	{
		super.create();
		FlxG.mouse.visible = false;
		level = new Level("test");
		add(level);

		pot = new Pot();
		level.placeAt(level.pot, pot);
		add(pot);

		light = new Light();
		level.placeAt(level.light, light);
		add(light);

		player = new Player();
		level.placeAt(level.start, player);
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
		player.setJump(FlxG.keys.pressed.UP || FlxG.keys.pressed.W);
		player.setAction(FlxG.keys.pressed.SPACE || FlxG.keys.pressed.E);

		super.update();
		player.resetCollidingPot();
		pot.playerCollide(player);
		pot.levelCollide(level);
		FlxG.collide(player, level);
	}
}
