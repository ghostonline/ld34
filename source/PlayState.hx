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
	var levelCompleteText:FlxText;
	var nextLevelButton:FlxButton;

	override public function create():Void
	{
		super.create();
		FlxG.mouse.visible = false;
		level = new Level("test");

		pot = new Pot();
		level.placeAt(level.pot, pot);

		light = new Light();
		level.placeAt(level.light, light);

		player = new Player();
		level.placeAt(level.start, player);

		levelCompleteText = new FlxText(0, 0, FlxG.width, "Level complete!", 24);
		levelCompleteText.alignment = "center";
		levelCompleteText.visible = false;

		nextLevelButton = new FlxButton(FlxG.width - 100, levelCompleteText.height + 10, "Next", nextLevel);
		nextLevelButton.visible = false;

		add(light);
		add(pot);
		add(player);
		add(pot.plant);
		add(level);
		add(levelCompleteText);
		add(nextLevelButton);
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

		if (light.isShiningOnPot(pot))
		{
			pot.addGrowthTick();
		}

		super.update();
		player.resetCollidingPot();
		pot.playerCollide(player);
		pot.levelCollide(level);
		FlxG.collide(player, level);

		if (pot.isGrown)
		{
			levelCompleteText.visible = true;
			FlxG.mouse.visible = true;
			nextLevelButton.visible = true;
		}
	}

	function nextLevel()
	{
		trace("BANG!");
	}
}
