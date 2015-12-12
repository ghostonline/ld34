package;
import flixel.FlxSprite;

class Player extends FlxSprite
{

	public function new()
	{
		super();
		loadGraphic("assets/images/player.png", false, 16, 16);

		maxVelocity.x = 80;
		maxVelocity.y = 200;
		drag.x = 1280;
		acceleration.y = maxVelocity.y;
	}

}
