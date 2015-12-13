package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

class PlayState extends FlxState
{
	var level:Level;
	var player:Player;
	var pot:Pot;
	var light:Light;
	var doors:FlxTypedGroup<Door>;
	var switches:FlxTypedGroup<Switch>;
	var levelCompleteText:FlxText;
	var nextLevelButton:FlxButton;
	var resetButton:FlxButton;

	override public function create():Void
	{
		super.create();
		var levelName = Reg.levels[Reg.level];
		level = new Level(levelName);

		pot = new Pot();
		level.placeAt(level.pot, pot);

		light = new Light();
		level.placeAt(level.light, light);
		light.x += level.tileWidth / 2;
		light.y += level.tileHeight / 2;

		doors = new FlxTypedGroup<Door>();
		for (def in level.doors)
		{
			var door = new Door(def.dir);
			level.placeAt(def.pos, door);
			doors.add(door);
		}

		switches = new FlxTypedGroup<Switch>();
		for (def in level.switches)
		{
			var switch_ = new Switch();
			level.placeAt(def, switch_);
			switch_.y += level.tileHeight - switch_.height;
			for (door in doors)
			{
				switch_.connectDoor(door);
			}
			switches.add(switch_);
		}

		player = new Player();
		level.placeAt(level.start, player);

		var victoryText = "Level complete!";
		var continueText = "Next";
		if (Reg.isLastLevel)
		{
			victoryText = "Game complete!";
			continueText = "Main menu";
		}

		levelCompleteText = new FlxText(0, 0, FlxG.width, victoryText, 24);
		levelCompleteText.alignment = "center";
		levelCompleteText.visible = false;

		nextLevelButton = new FlxButton(FlxG.width - 100, levelCompleteText.height + 10, continueText, nextLevel);
		nextLevelButton.visible = false;

		resetButton = new FlxButton(0, 0, "Reset", resetLevel);
		resetButton.x = FlxG.width - resetButton.width - 5;
		resetButton.y = FlxG.height - resetButton.height - 5;

		add(light);
		add(pot);
		add(switches);
		add(player);
		add(pot.plant);
		add(level);
		add(doors);
		add(levelCompleteText);
		add(nextLevelButton);
		add(resetButton);
	}

	override public function destroy():Void
	{
		super.destroy();
		level = null;
		player = null;
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
		pot.levelCollide(doors);
		pot.levelCollide(level);
		FlxG.collide(player, level);

		switches.callAll("prime");
		FlxG.overlap(player, switches, triggerSwitch);
		switches.callAll("checkTrigger");
		FlxG.collide(player, doors);

		if (pot.isGrown)
		{
			levelCompleteText.visible = true;
			nextLevelButton.visible = true;
		}
	}

	function triggerSwitch(player:Player, switch_:Switch)
	{
		switch_.trigger();
	}

	function nextLevel()
	{
		if (Reg.isLastLevel)
		{
			FlxG.switchState(new MenuState());
		}
		else
		{
			++Reg.level;
			FlxG.switchState(new PlayState());
		}
	}

	function resetLevel()
	{
		FlxG.switchState(new PlayState());
	}
}
