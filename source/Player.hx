package;
import flixel.FlxSprite;
import flixel.FlxObject;

class Player extends FlxSprite
{

	public function new()
	{
		super();
		loadGraphic("assets/images/player.png", false, 16, 16);

		maxVelocity.x = 80;
		maxVelocity.y = 300;
		drag.x = 1280;
		acceleration.y = maxVelocity.y;
	}

	public function setDirectionX(dir:Int)
	{
		acceleration.x = dir * drag.x;
		if (dir < 0) { flipX = true; }
		else if (dir > 0) { flipX = false; }
	}

	public function setJump(jumping:Bool)
	{
		if (jumping && isTouching(FlxObject.FLOOR))
		{
			velocity.y = -maxVelocity.y / 2;
		}
	}
}
