package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxBasic;
import flixel.FlxObject;

class Pot extends FlxSprite
{

	public function new()
	{
		super();
		loadGraphic("assets/images/pot.png");
		maxVelocity.y = 200;
		acceleration.y = maxVelocity.y;
		drag.x = 1280;
	}

	public function platformCollide(obj:FlxBasic)
	{
		allowCollisions = FlxObject.UP;
		FlxG.collide(obj, this);
	}

	public function levelCollide(obj:FlxBasic)
	{
		allowCollisions = FlxObject.ANY;
		FlxG.collide(obj, this);
	}
}
